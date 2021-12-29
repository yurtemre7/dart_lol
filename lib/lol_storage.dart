import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class LolStorage {
  final summonerStorage = new LocalStorage('summoners');
  final matchHistoryStorage = new LocalStorage('match_histories');
  final matchStorage = new LocalStorage('matches');

  Map<String, dynamic> getSummoner(String summonerName) {
    return json.decode(summonerStorage.getItem(summonerName));
  }

  saveSummoner(String key, String json) {
    summonerStorage.setItem(key, json);
  }

  Map<String, dynamic> getMatch(String matchId) {
    return json.decode(matchStorage.getItem("$matchId"));
  }

  saveMatch(String key, String json) {
    matchStorage.setItem(key, json);
  }

  List<dynamic> getMatchHistories(String puuid) {
    final matchHistoriesString = matchHistoryStorage.getItem(puuid);
    if (matchHistoriesString == null)
      return <dynamic>[];
    else return json.decode(matchHistoriesString);
  }

  /// 1. Get Match Histories
  /// 2. Create a set
  /// 3.
  /// 4. Save to storage
  saveMatchHistories(String puuid, String myJson) {
    final oldMatches = getMatchHistories(puuid);
    print("There are ${oldMatches.length} old matches");
    final newMatches = json.decode(myJson) as List<dynamic>;
    print("There are ${newMatches.length} new matches");
    /// No duplicates
    Set<String> mySet = {};
    oldMatches.forEach((element) {
      mySet.add(element);
    });
    newMatches.forEach((element) {
      mySet.add(element);
    });
    print("There are ${mySet.length} total matches");
    final that = mySet.toList();
    String theJson = jsonEncode(that);
    matchHistoryStorage.setItem(puuid, theJson);
  }
}
