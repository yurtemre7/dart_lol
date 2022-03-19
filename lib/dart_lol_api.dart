import 'dart:convert';
import 'package:dart_lol/LeagueStuff/runes_reforged.dart';
import 'package:dart_lol/LeagueStuff/summoner_spells.dart';
import 'package:dart_lol/LeagueStuff/league_entry_dto.dart';
import 'package:dart_lol/LeagueStuff/responses/league_response.dart';
import 'package:dart_lol/LeagueStuff/match.dart';
import 'package:dart_lol/rate_limiter.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'LeagueStuff/queues.dart';
import 'LeagueStuff/champion_mastery.dart';
import 'LeagueStuff/game_stats.dart';
import 'LeagueStuff/summoner.dart';
import 'helper/url_helper.dart';
import 'new_db_storage.dart';

enum APIType { summoner, overviews, match, league, challenger }

class LeagueAPI extends RateLimiter {
  // This is our global ServiceLocator
  GetIt getIt = GetIt.instance;

  /// This is the api-token you need to insert in order to use the League()
  /// instance and therefore the hole package xD!
  String apiToken;

  /// A string representation of the server, you want to get data from.
  ///
  /// e.g. "EUW1" for Europe West or "NA1" for North America.
  String? server;
  String? matchServer;

  /// Service Locator stuff
  List<ChampionMastery>? champMasteriesList;
  List<RunesReforged>? runesReforged;
  SummonerSpell? summonerSpell;
  List<Queues>? queues;

  /// used to build URLs for network requests
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

    ///GetIt Stuff
    getIt.registerSingleton<UrlHelper>(urlHelper);

    urlHelper.apiKey = this.apiToken;
  }

  Future init() async {
    await urlHelper.dDragonStorage.getVersionFromDb();
    summonerSpell = await urlHelper.dDragonStorage.getSummonerSpellsFromDb();
    runesReforged = await urlHelper.dDragonStorage.getRunesFromDb();
    queues = await urlHelper.dDragonStorage.getQueuesFromDb();

    getIt.registerSingleton<SummonerSpell>(summonerSpell!);
    getIt.registerSingleton<List<RunesReforged>>(runesReforged!);
    getIt.registerSingleton<List<Queues>>(queues!);

    final that = NewDbStorage();
    await that.saveThat();
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
  Future<LeagueResponse> getMatchHistoriesFromAPI(String puuid,
      {int start = 0, int count = 100}) async {
    var url =
        'https://$matchServer.api.riotgames.com/lol/match/v5/matches/by-puuid/$puuid/ids?start=$start&count=$count&api_key=$apiToken';
    final response = await makeApiCall(url, APIType.overviews, puuid: puuid);
    final list = response.matchOverviews;
    /// Build list of Strings
    final returnList = <String>[];
    list?.forEach((element) {
      returnList.add(element);
    });
    returnList.sort();
    response.matchOverviews = returnList;
    return response;
  }

  Future<LeagueResponse> makeApiCall(String url, APIType apiType, {String? puuid, String? summonerId, String? tier, String? division}) async {
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
            saveSummoner(s.name??"", response.body);
            return returnLeagueResponse(summoner: s);
          }
        case APIType.overviews:
          {
            saveMatchHistories(puuid??"", response.body);
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
            await saveMatch(match.metadata?.matchId??"", response.body);
            return returnLeagueResponse(match: match);
          }
        case APIType.league:
          {
            final rankedSummoner = LeagueEntryDto.fromJson(json.decode(response.body));
            saveRankedSummoner(summonerId??"", response.body);
            return returnLeagueResponse(rankedEntryDTO: rankedSummoner);
          }
        case APIType.challenger:
          final challengerPlayers = leagueEntryDtoFromJson(response.body);
          saveChallengerPlayers(tier!, division!, response.body);
          return returnLeagueResponse(rankedPlayers: challengerPlayers);
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

  Future<LeagueEntryDto?> getLeagueInfoFromAPI({String? summonerID}) async {
    var url = 'https://$server.api.riotgames.com/lol/league/v4/entries/by-summoner/$summonerID?api_key=$apiToken';
    final response = await makeApiCall(url, APIType.league);
    return response.leagueEntryDto;
  }

  Future<List<LeagueEntryDto>?> getChallengerPlayersFromAPI(String queue, String tier, String division, {int page = 1}) async {
    var url = 'https://$server.api.riotgames.com/lol/league-exp/v4/entries/$queue/$tier/$division?page=$page&api_key=$apiToken';
    final response = await makeApiCall(url, APIType.challenger, tier: tier, division: division);
    return response.rankedPlayers;
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
      case SortBy.NAME:
        return "NAME";
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
  static String getValue(Queue queue, {bool returnShortVersion = false}) {
    switch(queue) {
      case Queue.RANKED_SOLO_5X5:
        if(returnShortVersion)
          return "Solo";
        return "RANKED_SOLO_5x5";
      case Queue.RANKED_FLEX_SR:
        if(returnShortVersion)
          return "Flex";
        return "RANKED_FLEX_SR";
      default:
        if(returnShortVersion)
          return "Solo";
        return "RANKED_SOLO_5x5";
    }
  }
}

class TiersHelper {
  static String getValue(Tier tier, {bool returnShortVersion = false}) {
    switch(tier) {
      case Tier.CHALLENGER:
        if(returnShortVersion)
          return "Challenger";
        return "CHALLENGER";
      case Tier.GRANDMASTER:
        if(returnShortVersion)
          return "Grandmaster";
        return "GRANDMASTER";
      case Tier.MASTER:
        if(returnShortVersion)
          return "Master";
        return "MASTER";
      case Tier.DIAMOND:
        if(returnShortVersion)
          return "Diamond";
        return "DIAMOND";
      case Tier.PLATINUM:
        if(returnShortVersion)
          return "Platinum";
        return "PLATINUM";
      case Tier.GOLD:
        if(returnShortVersion)
          return "Gold";
        return "GOLD";
      case Tier.SILVER:
        if(returnShortVersion)
          return "Silver";
        return "SILVER";
      case Tier.BRONZE:
        if(returnShortVersion)
          return "Bronze";
        return "BRONZE";
      case Tier.IRON:
        if(returnShortVersion)
          return "Iron";
        return "IRON";
      default:
        if(returnShortVersion)
          return "Challenger";
        return "CHALLENGER";
    }
  }
}