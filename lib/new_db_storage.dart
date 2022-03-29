import 'dart:convert';
import 'package:localstorage/localstorage.dart';

import 'LeagueStuff/summoner.dart';

class NewDbStorage {
  ///had to do this to get app to create local storage (on main app)
  ///https://github.com/lesnitsky/flutter_localstorage/issues/60#issuecomment-1029172576
  final LocalStorage summonerStorage = LocalStorage('summoners_storage');
  final LocalStorage matchHistoryStorage = LocalStorage('match_histories');
  final LocalStorage matchStorage = LocalStorage('matches');
  final LocalStorage rankedChallengerSoloStorage = LocalStorage('ranked_challenger_solo');

  saveSummoner(String summonerName, String summonerJson) {
    summonerName = summonerName.toLowerCase();
    summonerStorage.setItem(summonerName, summonerJson);
  }

  String favoriteSummonersKey = "my_favorite_summoners";
  saveFavoriteSummoners(String summonerName) {
    summonerName = summonerName.toLowerCase();
    final that = getFavoriteSummoners();
    that.add(summonerName);
    summonerStorage.setItem(favoriteSummonersKey, json.encode(that));
  }

  removeFavoriteSummoner(String name) {
    final summoners = getFavoriteSummoners();
    summoners.removeWhere((element) => element == name);
    summonerStorage.setItem(favoriteSummonersKey, json.encode(summoners));
  }

  List<String> getFavoriteSummoners() {
    final favorites = summonerStorage.getItem(favoriteSummonersKey);
    if(favorites == null) {
      return <String>[];
    }
    final that = json.decode(favorites);
    return that;
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
