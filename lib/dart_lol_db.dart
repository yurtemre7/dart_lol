library dart_lol;

import 'package:dart_lol/LeagueStuff/responses/league_response.dart';
import 'package:dart_lol/dart_lol_api.dart';
import 'package:dart_lol/LeagueStuff/match.dart';
import 'LeagueStuff/summoner.dart';

class LeagueDB extends LeagueAPI {

  LeagueDB({
    required apiToken,
    required String server,
    int lowerLimitCount = 20,
    int upperLimitCount = 100}) :
        super(apiToken: apiToken, server: server, appLowerLimitCount: lowerLimitCount, appUpperLimitCount: upperLimitCount);

  /// Get summoner from database
  /// If fallbackAPI == true then if not found then will call RIOT API
  Future<LeagueResponse?> getSummonerFromDb(String name, bool fallbackAPI) async {
    final s = storage.summonerStorage.getItem("$name");
    if(s != null) {
      final newS = Summoner.fromJson(s);
      return s;
    }else if(fallbackAPI)
      return getSummonerInfo(name);
    else return null;
  }

  /// https://americas.api.riotgames.com/lol/match/v5/matches/NA1_4056249988?api_key=RGAPI-8567f359-587c-4742-a791-7fd5748be91a
  /// Get a match from RIOT api MatchV5
  /// Takes a matchID from matchHistoryV5
  Future<LeagueResponse> getMatch(String matchId, {bool fallbackAPI = true}) async {
    final valueMap = storage.getMatch("$matchId");
    if(valueMap.isNotEmpty) {
      print("Match received from database");
      final that = Match.fromJson(valueMap);
      return returnLeagueResponse(match: that);
    } else if (fallbackAPI == false)
      return returnLeagueResponse();
    else {
      var url = 'https://$matchServer.api.riotgames.com/lol/match/v5/matches/$matchId?api_key=$apiToken';
      var lr = makeApiCall(url, APIType.match) as LeagueResponse;
      storage.saveMatch(matchId, lr.match!.toJson().toString());
      return lr;
    }
  }

  Future<List<dynamic>> getMatchesFromDb(String puuid, {bool allMatches = true, int start = 0, int count = 100, bool fallBackAPI = true}) async {
    print("Getting matches from DB");
    final list = storage.getMatchHistories(puuid);
    if (fallBackAPI && list.isEmpty) {
      return getMatches(puuid, start: start, count: count);
    }
    if(allMatches)
      return list;
    final returnList = [];
    for (int i = start; i < count; i++) {
      returnList.add(list[i]);
    }
    return returnList;
  }
}
