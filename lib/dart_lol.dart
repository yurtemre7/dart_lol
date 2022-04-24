library dart_lol;

import 'dart:convert';

import 'package:dart_lol/LeagueStuff/responses/league_response.dart';
import 'package:dart_lol/dart_lol_api.dart';
import 'package:dart_lol/LeagueStuff/match.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'LeagueStuff/league_entry_dto.dart';

class League extends LeagueAPI {
  League({required apiToken, required String server, int lowerLimitCount = 20, int upperLimitCount = 100}): super(apiToken: apiToken, server: server,
            appLowerLimitCount: lowerLimitCount,
            appUpperLimitCount: upperLimitCount);

  /// Summoner
  Future<LeagueResponse?> getSummonerFromDb(String name, bool fallbackAPI) async {
    name = name.toLowerCase().trim();
    final s = await myLocalStorage?.getSummoner("$name");
    if (s != null) {
      return returnLeagueResponse(summoner: s);
    } else if (fallbackAPI) {
      final summoner = await getSummonerFromAPI(name);
      return summoner;
    }
    else {
      return null;
    }
  }
  /// Summoner

  /// Match
  Future<LeagueResponse> getMatch(String matchId, {bool fallbackAPI = true}) async {
    var store = StoreRef.main();
    final db = GetIt.instance<Database>();
    var valueMap = await store.record(matchId).get(db);
    if (valueMap != null) {
      final that = json.decode(valueMap as String);
      final matchFromJson = Match.fromJson((that));
      return returnLeagueResponse(match: matchFromJson);
    } else if (fallbackAPI == false)
      return returnLeagueResponse();
    else {
      var url =
          'https://$matchServer.api.riotgames.com/lol/match/v5/matches/$matchId?api_key=$apiToken';
      var match = await makeApiCall(url, APIType.match);
      return match;
    }
  }
  /// Match

  /// Match Histories
  Future<LeagueResponse> getMatchHistories(String puuid, {bool allMatches = true, int start = 0, int count = 100, bool fallBackAPI = true, bool forceApi = false}) async {
    var store = StoreRef.main();
    final db = GetIt.instance<Database>();
    var matchHistoryString = await store.record(puuid).get(db);
    if (forceApi || matchHistoryString == null) {
      final histories = await getMatchHistoriesFromAPI(puuid, start: start, count: count);
      return histories;
    }
    final list = json.decode(matchHistoryString);
    if (allMatches) {
      final returnList = <String>[];
      list.forEach((element) {
        returnList.add(element as String);
      });
      returnList.sort((a, b) => b.compareTo(a));
      return LeagueResponse(matchOverviews: returnList);
    }
      final returnList = <String>[];
      for (int i = start; i < count; i++) {
        returnList.add(list[i]);
      }
      returnList.sort((a, b) => b.compareTo(a));
      return LeagueResponse(matchOverviews: returnList);
    }
  /// Match Histories

  /// Challenger Players
  Future<List<LeagueEntryDto>?> getChallengerPlayers(String queue, String tier, String division, {int page = 1, bool fallbackAPI = true}) async {
    List<LeagueEntryDto> list = [];
    var store = StoreRef.main();
    final db = GetIt.instance<Database>();
    final newPlayers = await store.record("$tier-$division").get(db);
    //final newPlayers = myLocalStorage?.rankedChallengerSoloStorage.getItem("$tier-$division");
    if(newPlayers == null && fallbackAPI == true) {
      if(newPlayers == null) {
        print("Getting from API because there are no challenger players in database");
      }
      final rankedPlayed = await getChallengerPlayersFromAPI(queue, tier, division);
      return rankedPlayed;
    }
    final myLeagueEntryForThisPage = leagueEntryDtoFromJson(newPlayers);
    myLeagueEntryForThisPage.forEach((element) {
      list.add(element);
    });
    return list;
  }
  /// Challenger Players

  /*Future<List<Rank>> getRankedStatsForSummoner(String summonerId) async {
    final rank = storage.getChallengerPlayers(tier, division)
  }*/
}
