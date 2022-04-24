import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:localstorage/localstorage.dart';
import 'package:sembast/sembast_io.dart';

import 'LeagueStuff/summoner.dart';
import 'package:sembast/sembast.dart';

class NewDbStorage {
  /// Do this in main.dart to get app to create local storage
  /// https://github.com/lesnitsky/flutter_localstorage/issues/60#issuecomment-1029172576

  Future saveSummoner(String summonerName, String summonerJson) async {
    summonerName = summonerName.toLowerCase();
    var store = StoreRef.main();
    final db = GetIt.instance<Database>();
    await store.record(summonerName).put(db, summonerJson);
  }

  Future<Summoner?> getSummoner(String summonerName) async {
    summonerName = summonerName.toLowerCase();
    var store = StoreRef.main();
    final db = GetIt.instance<Database>();
    var item = await store.record(summonerName).get(db);
    if(item == null) {
      return null;
    }
    final s = json.decode(item as String);
    return Summoner.fromJson(s);
  }

  String recentlySearchedSummonersKey = "recently_searched_summoners_key";
  Future saveRecentlySearchedSummoner(String summonerName) async {
    summonerName = summonerName.toLowerCase();
    final recentlySearched = await getRecentlySearchedSummoners();
    if(!recentlySearched.contains(summonerName)) {
      recentlySearched.add(summonerName);
      var store = StoreRef.main();
      final db = GetIt.instance<Database>();
      await store.record(recentlySearchedSummonersKey).put(db, json.encode(recentlySearched));
      //summonerStorage.setItem(recentlySearchedSummonersKey, json.encode(recentlySearched));
    }
  }

  Future<List> getRecentlySearchedSummoners() async {
    //final recentlySearched = summonerStorage.getItem(recentlySearchedSummonersKey);
    var store = StoreRef.main();
    final db = GetIt.instance<Database>();
    var recentlySearched = await store.record(recentlySearchedSummonersKey).get(db);
    if(recentlySearched == null) {
      return <dynamic>[];
    }
    final list = json.decode(recentlySearched);
    return list;
  }

  Future removeRecentlySearchedSummoner(String summonerName) async {
    final recentlySearched = await getRecentlySearchedSummoners();
    summonerName = summonerName.toLowerCase();
    recentlySearched.removeWhere((element) => element == summonerName);
    var store = StoreRef.main();
    final db = GetIt.instance<Database>();
    await store.record(recentlySearchedSummonersKey).put(db, json.encode(recentlySearched));
    //await summonerStorage.setItem(recentlySearchedSummonersKey, json.encode(recentlySearched));
  }

  Future saveFavoriteSummoner(String summonerName) async {
    if(summonerName == "") {
      return;
    }
    final s = await getSummoner(summonerName);
    s?.isFavorite = true;
    saveSummoner(summonerName, json.encode(s));
  }

  Future removeFavoriteSummoner(String summonerName) async {
    final s = await getSummoner(summonerName);
    s?.isFavorite = false;
    await saveSummoner(summonerName, json.encode(s));
  }

  Future saveMatch(String matchId, String matchJson) async {
    print("Saving match");
    try {
      //matchStorage.setItem(matchId, matchJson);
      var store = StoreRef.main();
      final db = GetIt.instance<Database>();
      await store.record(matchId).put(db, matchJson);
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
  Future saveMatchHistories(String puuid, String newJson) async {
    //final oldJson = matchHistoryStorage.getItem(puuid);
    var store = StoreRef.main();
    final db = GetIt.instance<Database>();
    var oldJson = await store.record(puuid).get(db);
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
    await store.record(puuid).put(db, theJson);
  }

  Future saveChallengerPlayers(String tier, String division, String json) async {
    var store = StoreRef.main();
    final db = GetIt.instance<Database>();
    await store.record("$tier-$division").put(db, json);
    //rankedChallengerSoloStorage.setItem("$tier-$division", json);
  }

  String rankedSummonerKey = 'ranked_summoner_key_';
  Future saveRankedSummoner(String summonerId, String json) async {
    var store = StoreRef.main();
    final db = GetIt.instance<Database>();
    await store.record("$rankedSummonerKey$summonerId").put(db, json);
  }
}
