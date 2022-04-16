import 'dart:convert';
import 'package:localstorage/localstorage.dart';

import 'LeagueStuff/summoner.dart';

class NewDbStorage {
  /// Do this in main.dart to get app to create local storage
  /// https://github.com/lesnitsky/flutter_localstorage/issues/60#issuecomment-1029172576
  final LocalStorage summonerStorage = LocalStorage('summoners_storage');
  final LocalStorage matchHistoryStorage = LocalStorage('match_histories');
  final LocalStorage matchStorage = LocalStorage('matches');
  final LocalStorage rankedChallengerSoloStorage = LocalStorage('ranked_challenger_solo');

  saveSummoner(String summonerName, String summonerJson) async {
    summonerName = summonerName.toLowerCase();
    await summonerStorage.setItem(summonerName, summonerJson);
  }

  Future<Summoner?> getSummoner(String summonerName) async {
    summonerName = summonerName.toLowerCase();
    final item = await summonerStorage.getItem("$summonerName");
    if(item == null) {
      return null;
    }
    final s = json.decode(item);
    return Summoner.fromJson(s);
  }

  String recentlySearchedSummonersKey = "recently_searched_summoners_key";
  saveRecentlySearchedSummoner(String summonerName) async {
    summonerName = summonerName.toLowerCase();
    final recentlySearched = await getRecentlySearchedSummoners();
    if(!recentlySearched.contains(summonerName)) {
      recentlySearched.add(summonerName);
      summonerStorage.setItem(recentlySearchedSummonersKey, json.encode(recentlySearched));
    }
  }

  Future<List> getRecentlySearchedSummoners() async {
    final recentlySearched = summonerStorage.getItem(recentlySearchedSummonersKey);
    if(recentlySearched == null) {
      return <dynamic>[];
    }
    final list = json.decode(recentlySearched);
    return list;
  }

  removeRecentlySearchedSummoner(String summonerName) async {
    final recentlySearched = await getRecentlySearchedSummoners();
    summonerName = summonerName.toLowerCase();
    recentlySearched.removeWhere((element) => element == summonerName);
    await summonerStorage.setItem(recentlySearchedSummonersKey, json.encode(recentlySearched));
  }

  saveFavoriteSummoner(String summonerName) async {
    if(summonerName == "") {
      return;
    }
    final s = await getSummoner(summonerName);
    s?.isFavorite = true;
    saveSummoner(summonerName, json.encode(s));
  }

  removeFavoriteSummoner(String summonerName) async {
    final s = await getSummoner(summonerName);
    s?.isFavorite = false;
    await saveSummoner(summonerName, json.encode(s));
  }

  saveMatch(String matchId, String matchJson) {
    print("Saving match");
    try {
      matchStorage.setItem(matchId, matchJson);
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
  saveMatchHistories(String puuid, String newJson) {
    final oldJson = matchHistoryStorage.getItem(puuid);
    var oldMatches = [];
    if(oldJson != null) {
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
    matchHistoryStorage.setItem(puuid, theJson);
  }

  saveChallengerPlayers(String tier, String division, String json) {
    rankedChallengerSoloStorage.setItem("$tier-$division", json);
  }

  String rankedSummonerKey = 'ranked_summoner_key_';
  saveRankedSummoner(String summonerId, String json) {
    summonerStorage.setItem("$rankedSummonerKey$summonerId", json);
  }
}
