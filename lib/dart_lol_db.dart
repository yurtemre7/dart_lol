library dart_lol;

import 'dart:convert';

import 'package:dart_lol/LeagueStuff/responses/league_response.dart';
import 'package:dart_lol/dart_lol_api.dart';
import 'package:dart_lol/LeagueStuff/match.dart';
import 'package:localstorage/localstorage.dart';
import 'LeagueStuff/league_entry_dto.dart';
import 'LeagueStuff/rank.dart';
import 'LeagueStuff/summoner.dart';

class LeagueDB extends LeagueAPI {
  LeagueDB({required apiToken, required String server, int lowerLimitCount = 20, int upperLimitCount = 100}): super(apiToken: apiToken, server: server,
            appLowerLimitCount: lowerLimitCount,
            appUpperLimitCount: upperLimitCount);

  final _summonerStorage = new LocalStorage('summoners_storage');
  final _matchHistoryStorage = new LocalStorage('match_histories');
  final _matchStorage = new LocalStorage('matches');
  final _rankedChallengerSoloStorage = new LocalStorage('ranked_challenger_solo');

  /// Summoner
  Future<LeagueResponse?> getSummonerFromDb(String name, bool fallbackAPI) async {
    final s = _summonerStorage.getItem("$name");
    if (s != null) {
      final newS = Summoner.fromJson(json.decode(s));
      return returnLeagueResponse(summoner: newS);
    } else if (fallbackAPI) {
      final summoner = await getSummonerFromAPI(name);
      saveSummoner(name, summoner.summoner?.toJson().toString()??"");
    }
    else {
      return null;
    }
  }

  Future saveSummoner(String summonerName, String summonerJson) async {
    if(summonerJson == "") {
      print("we're saving summoner json == ''");
    }
    await _summonerStorage.setItem(summonerName, summonerJson);
  }
  /// Summoner


  /// Match
  Future<LeagueResponse> getMatch(String matchId, {bool fallbackAPI = true}) async {
    final valueMap = _matchStorage.getItem("$matchId");
    print("inside getMatch");
    print(valueMap);
    print(valueMap.runtimeType);
    if (valueMap != null) {
      final that = json.decode(valueMap);
      final matchFromJson = Match.fromJson((that));
      print(matchFromJson.metadata?.matchId);
      return returnLeagueResponse(match: matchFromJson);
    } else if (fallbackAPI == false)
      return returnLeagueResponse();
    else {
      var url =
          'https://$matchServer.api.riotgames.com/lol/match/v5/matches/$matchId?api_key=$apiToken';
      var match = await makeApiCall(url, APIType.match);
      await saveMatch(match.match?.metadata!.matchId??"", json.encode(match.match?.toJson()));
      return match;
    }
  }

  saveMatch(String matchId, String matchJson) async {
    try {
      await _matchStorage.setItem(matchId, matchJson);
    }on FormatException catch (e) {
      print("we cannot save this match $matchId");
    }on Exception catch (e) {
      print("we cannot save this match $matchId");
    }on Error catch (e) {
      print("we cannot save this match $matchId");
    }catch (e) {
      print("we cannot save this match $matchId");
    }
  }
  /// Match

  /// Match Histories
  Future<LeagueResponse> getMatchHistories(String puuid, {bool allMatches = true, int start = 0, int count = 100, bool fallBackAPI = true, bool forceApi = false}) async {
    final matchHistoryString = _matchHistoryStorage.getItem(puuid);
    print("Match histories from db:");
    if (forceApi || matchHistoryString == null) {
      final histories = await getMatchHistoriesFromAPI(puuid, start: start, count: count);
      if (matchHistoryString != null) {
        saveMatchHistories(puuid, json.encode(histories.matchOverviews), json.encode(matchHistoryString));
      }else{
        saveMatchHistories(puuid, json.encode(histories.matchOverviews), "");
      }
      print("Returning from api");
      return histories;
    }
    final list = json.decode(matchHistoryString);
    if (allMatches) {
      final returnList = <String>[];
      list.forEach((element) {
        returnList.add(element as String);
      });
      returnList.sort();
      print("Returning all matches");
      return LeagueResponse(matchOverviews: returnList);
    }
      final returnList = <String>[];
      for (int i = start; i < count; i++) {
        returnList.add(list[i]);
      }
      returnList.sort();
      print("Returning at end");
      return LeagueResponse(matchOverviews: returnList);
    }

  /// 1. Get old match histories
  /// 2. Convert new match histories
  /// 3. Add 1 and 2 to a Set
  /// 4. Save Set to local storage
  saveMatchHistories(String puuid, String newJson, String oldJson) async {
    print("Saving match histories");
    var oldMatches = [];
    if(oldJson != "") {
      oldMatches = json.decode(oldJson);
    }
    final newMatches = json.decode(newJson);
    print("${oldMatches.length} old matches");
    print("${newMatches.length} new matches");
    /// Prevent duplicates
    Set<String> matchesSet = {};
    oldMatches..forEach((element) {
      matchesSet.add(element);
    });
    newMatches.forEach((element) {
      matchesSet.add(element);
    });
    print("${matchesSet.length} total matches");
    final that = matchesSet.toList();
    String theJson = jsonEncode(that);
    await _matchHistoryStorage.setItem(puuid, theJson);
  }
  /// Match Histories

  /// Challenger Players
  Future<List<LeagueEntryDto>> getChallengerPlayers(String queue, String tier, String division, {int page = 1, bool fallbackAPI = true}) async {
    bool keepSearching = true;
    int pageNumber = 1;
    List<LeagueEntryDto> list = [];
    final newPlayers = _rankedChallengerSoloStorage.getItem("$division-$pageNumber");
    if(newPlayers == null && fallbackAPI == true) {
      final rankedPlayed = await getChallengerPlayersFromAPI(queue, tier, division);
      saveChallengerPlayers(tier, division, json.encode(rankedPlayed));
      return rankedPlayed;
    }
    while(keepSearching) {
      final newPlayers = _rankedChallengerSoloStorage.getItem("$division-$pageNumber");
      if (newPlayers == null) {
        keepSearching = false;
      }else {
        final myLeagueEntryForThisPage = leagueEntryDtoFromJson(newPlayers);
        list.addAll(myLeagueEntryForThisPage);
        pageNumber++;
      }
    }
    return list;
  }

  saveChallengerPlayers(String tier, String division, String json) async {
    await _rankedChallengerSoloStorage.setItem("$tier-$division", json);
  }
  /// Challenger Players


  String rankedSummonerKey = 'ranked_summoner_key_';
  saveRankedSummoner(String summonerId, String json) async {
    await _summonerStorage.setItem("$rankedSummonerKey$summonerId", json);
  }
  /*Future<List<Rank>> getRankedStatsForSummoner(String summonerId) async {
    final rank = storage.getChallengerPlayers(tier, division)
  }*/
}
