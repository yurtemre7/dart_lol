import 'dart:convert';

import 'package:localstorage/localstorage.dart';

class DbStore {
  final summonerStorage = new LocalStorage('summoners_storage');
  final matchHistoryStorage = new LocalStorage('match_histories');
  final matchStorage = new LocalStorage('matches');
  final rankedChallengerSoloStorage = new LocalStorage('ranked_challenger_solo');

  Future saveSummoner(String summonerName, String summonerJson) async {
    if(summonerJson == "") {
      print("we're saving summoner json == ''");
      return;
    }
    await summonerStorage.setItem(summonerName, summonerJson);
  }

  saveMatch(String matchId, String matchJson) async {
    try {
      await matchStorage.setItem(matchId, matchJson);
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

  /// 1. Get old match histories
  /// 2. Convert new match histories
  /// 3. Add 1 and 2 to a Set
  /// 4. Save Set to local storage
  saveMatchHistories(String puuid, String newJson) async {
    final oldJson = matchHistoryStorage.getItem(puuid);
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
    await matchHistoryStorage.setItem(puuid, theJson);
  }

  saveChallengerPlayers(String tier, String division, String json) async {
    await rankedChallengerSoloStorage.setItem("$tier-$division", json);
  }

  String rankedSummonerKey = 'ranked_summoner_key_';
  saveRankedSummoner(String summonerId, String json) async {
    await summonerStorage.setItem("$rankedSummonerKey$summonerId", json);
  }
}