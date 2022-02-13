import 'dart:collection';
import 'dart:convert';

import 'package:dart_lol/LeagueStuff/league_entry_dto.dart';
import 'package:dart_lol/LeagueStuff/responses/league_response.dart';
import 'package:dart_lol/dart_lol_db.dart';
import 'package:dart_lol/LeagueStuff/match.dart';
import 'package:dart_lol/rate_limiter.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'LeagueStuff/champion_mastery.dart';
import 'LeagueStuff/game_stats.dart';
import 'LeagueStuff/rank.dart';
import 'LeagueStuff/summoner.dart';
import 'ddragon_storage.dart';
import 'helper/url_helper.dart';
import 'helper/logging.dart';
import 'lol_storage.dart';

enum APIType { summoner, matchOverviews, match }

class LeagueAPI extends RateLimiter {
  // This is our global ServiceLocator
  GetIt getIt = GetIt.instance;

  /// Local storage so we can save match histories
  final storage = LolStorage();

  /// This is the api-token you need to insert in order to use the League()
  /// instance and therefore the hole package xD!
  String apiToken;

  /// A string representation of the server, you want to get data from.
  ///
  /// e.g. "EUW1" for Europe West or "NA1" for North America.
  String? server;
  String? matchServer;

  /// List contains every champion with their according mastery stat.
  List<ChampionMastery>? champMasteriesList;

  /// Class League() instance to use to get several
  /// information about an player.
  /// Requiers an api-token from the official
  /// League developer page:
  /// * https://developer.riotgames.com/
  ///
  /// e.g. "EUW1" for Europe West or "NA1" for North America.
  ///
  DDragonStorage dDragonStorage = DDragonStorage();
  UrlHelper urlHelper = UrlHelper();

  LeagueAPI(
      {required this.apiToken,
      required String server,
      int appLowerLimitCount = 20,
      int appUpperLimitCount = 100}) {
    this.server = server.toLowerCase();
    if (this.server == "na1") this.matchServer = "americas";

    //custom rate limit stuff
    this.appMaxCallsPerSecond = appLowerLimitCount;
    this.appMaxCallsPerTwoMinutes = appUpperLimitCount;

    getIt.registerSingleton<UrlHelper>(urlHelper);
    getIt.registerSingleton<DDragonStorage>(dDragonStorage);
    urlHelper.apiKey = this.apiToken;
  }

  /// Get an Future instance of the Summoner() class.
  /// So use the
  /// ```
  /// .then(onValue){
  ///
  /// }
  /// ```
  /// method to get their name, account id, level and revision date.
  Future<LeagueResponse> getSummonerFromAPI(String summonerName) async {
    var url =
        'https://$server.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerName?api_key=$apiToken';
    var response = await makeApiCall(url, APIType.summoner);
    if (response.summoner != null) {
      storage.saveSummoner(
          summonerName, response.summoner!.toJson().toString());
    }
    return response;
  }

  /// Get an Future instance of the Game class as a List of it.
  /// So use the
  /// ```
  /// .then(onValue){
  ///   onValue[x]  //where x is the game you want (0 most-recent)
  /// }
  /// ```
  /// method to get their champion name, level and if chest aquired.
  /// https://americas.api.riotgames.com/lol/match/v5/matches/by-puuid/8da3a1nbj_aeMjIW59139Hx545oBL9kcuQtvkrWImpXJD6IQD_UQ9xejArpgzfQxcxD4LMnwVtD-3g/ids?start=0&count=20
  Future<LeagueResponse> getMatchesFromAPI(String puuid,
      {int start = 0, int count = 100}) async {
    var url =
        'https://$matchServer.api.riotgames.com/lol/match/v5/matches/by-puuid/$puuid/ids?start=$start&count=$count&api_key=$apiToken';
    final response = await makeApiCall(url, APIType.matchOverviews);
    final list = response.matchOverviews;
    storage.saveMatchHistories(puuid, json.encode(response.matchOverviews));
    /// Build list of Strings
    final returnList = <String>[];
    list?.forEach((element) {
      returnList.add(element as String);
    });
    returnList.sort();
    print("returning ${returnList.length} matches");
    response.matchOverviews = returnList;
    return response;
  }

  /// Get all matches, find the end
  Future<LeagueResponse> getAllMatchesFromAPI(String puuid) async {
    final returnList = <String>[];
    var keepSearching = true;
    var start = 0;
    final count = 100;
    LeagueResponse response = LeagueResponse();
    while (keepSearching) {
      response = await getMatchesFromAPI(puuid, start: start, count: count);
      print("${response.matchOverviews?.length} new matches");
      response.matchOverviews?.forEach((element) {
        returnList.add(element);
      });
      final lengthOfMatchOverviews = response.matchOverviews?.length??0;
      if(lengthOfMatchOverviews < 100) {
        keepSearching = false;
      }else {
        start += 100;
        await Future.delayed(const Duration(seconds: 1), (){});
      }
    }
    print("${returnList.length} total matches");
    return response;
  }

  Future<LeagueResponse> makeApiCall(String url, APIType apiType) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (!passesApiCallsRateLimit(now))
      returnLeagueResponse(responseCode: 429, retryTimestamp: now + 30000);
    if (!passesHeaderRateLimit(now))
      returnLeagueResponse(responseCode: 429, retryTimestamp: now + 30000);

    apiCalls.add(now);
    print("url: $url");
    var response = await http.get(Uri.parse(url),);
    final headers = response.headers;
    updateHeaders(headers);
    if (response.statusCode == 200) {
      switch (apiType) {
        case APIType.summoner:
          {
            final s = Summoner.fromJson(json.decode(response.body));
            return returnLeagueResponse(summoner: s);
          }
        case APIType.matchOverviews:
          {
            final list = json.decode(response.body) as List<dynamic>;
            final returnList = <String>[];
            list.forEach((element) {
              returnList.add(element);
            });
            return returnLeagueResponse(matchOverviews: returnList);
          }
        case APIType.match:
          {
            final match = Match.fromJson(json.decode(response.body));
            storage.saveMatch(match.metadata!.matchId!, response.body);
            return returnLeagueResponse(match: match);
          }
      }
    } else if (response.statusCode == 429) {
      print("We received a 429");
      final tempRetryHeader = headers["retry-after"];
      final secondsToWait = int.parse(tempRetryHeader!);
      final msToWait = secondsToWait * 1000;
      final retryTimeStamp = msToWait + now;
      return returnLeagueResponse(
          responseCode: response.statusCode, retryTimestamp: retryTimeStamp);
    } else {
      return returnLeagueResponse(responseCode: response.statusCode);
    }
  }

  /// Get an Future instance of the ChampionMasteries class.
  /// So use the
  /// ```
  /// .then(onValue){
  ///
  /// }
  /// ```
  /// method to get their champion name, level and if chest aquired.
  Future<List<ChampionMastery>?> getChampionMasteriesFromAPI(
      {String? summonerID}) async {
    var url =
        'https://$server.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/$summonerID?api_key=$apiToken';
    var response = await http.get(
      Uri.parse(url),
    );
    var championMasteries = json.decode(
      response.body,
    );

    champMasteriesList = [];
    championMasteries.forEach(
      (championMastery) {
        champMasteriesList!.add(
          ChampionMastery.fromJson(
            json.decode(json.encode(championMastery)),
          ),
        );
      },
    );

    return champMasteriesList;
  }

  Future<Rank> getRankInfoFromAPI({String? summonerID}) async {
    var url =
        'https://$server.api.riotgames.com/lol/league/v4/entries/by-summoner/$summonerID?api_key=$apiToken';
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.body.toString() != '[]') {
      return Rank.fromJson(
        json.decode(
          response.body,
        )[0],
      );
    } else {
      return Rank(
          hotStreak: false,
          leagueId: '0',
          leaguePoints: 0,
          losses: 0,
          wins: 0,
          rank: 'unranked',
          tier: 'no tier');
    }
  }

  Future<GameStat?> getCurrentGameFromAPI(
      {String? summonerID, String? summonerName}) async {
    var url =
        'https://$server.api.riotgames.com/lol/spectator/v4/active-games/by-summoner/$summonerID?api_key=$apiToken';
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode != 404) {
      return GameStat.fromJson(
        json.decode(
          response.body,
        ),
        summonerName,
        summonerID,
      );
    }
    return null;
  }

  Future<List<LeagueEntryDto?>?> getRankedQueueFromAPI(String queue, String tier, String division, {int page = 1}) async {
    var url = 'https://$server.api.riotgames.com/lol/league-exp/v4/entries/$queue/$tier/$division?page=$page&api_key=$apiToken';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode != 404) {
      print(response.body);
      storage.saveChallenger(division, page, response.body);
      return leagueEntryDtoFromJson((response.body));
    }
    return null;
  }
}

enum Queue {
  RANKED_SOLO_5X5,
  RANKED_FLEX_SR
}

enum Tier {
  CHALLENGER,
  GRANDMASTER,
  MASTER,
  DIAMOND,
  PLATINUM,
  GOLD,
  SILVER,
  BRONZE,
  IRON
}

enum Division {
  I,
  II,
  III,
  IV
}

enum SortBy {
  LP,
  WINS,
  LOSSES,
  NAME
}

class SortByHelper {
  static String getValue(SortBy sortBy) {
    switch(sortBy) {
      case SortBy.LP:
        return "LP";
      case SortBy.WINS:
        return "WINS";
      case SortBy.LOSSES:
        return "LOSSES";
      default:
        return "LP";
    }
  }
}

class DivisionsHelper {
  static String getValue(Division division) {
    switch(division) {
      case Division.I:
        return "I";
      case Division.II:
        return "II";
      case Division.III:
        return "III";
      case Division.IV:
        return "IV";
      default:
        return "I";
    }
  }
}

class QueuesHelper {
  static String getValue(Queue queues) {
    switch(queues) {
      case Queue.RANKED_SOLO_5X5:
        return "RANKED_SOLO_5x5";
      case Queue.RANKED_FLEX_SR:
        return "RANKED_FLEX_SR";
      default:
        return "RANKED_SOLO_5x5";
    }
  }
}

class TiersHelper {
  static String getValue(Tier tiers) {
    switch(tiers) {
      case Tier.CHALLENGER:
        return "CHALLENGER";
      case Tier.GRANDMASTER:
        return "GRANDMASTER";
      case Tier.MASTER:
        return "MASTER";
      case Tier.DIAMOND:
        return "DIAMOND";
      case Tier.PLATINUM:
        return "PLATINUM";
      case Tier.GOLD:
        return "GOLD";
      case Tier.SILVER:
        return "SILVER";
      case Tier.BRONZE:
        return "BRONZE";
      case Tier.IRON:
        return "IRON";
      default:
        return "CHALLENGER";
    }
  }
}