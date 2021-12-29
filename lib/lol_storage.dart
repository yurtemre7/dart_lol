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
    print("Getting match $matchId from database");
    final matchString = matchStorage.getItem("$matchId");
    if(matchString == null)
      return {};
    else return json.decode(matchString);
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

  /// 1. Get old match histories
  /// 2. Convert new match histories
  /// 3. Add 1 and 2 to a Set
  /// 4. Save Set to local storage
  saveMatchHistories(String puuid, String myJson) {
    final oldMatches = getMatchHistories(puuid);
    print("${oldMatches.length} old matches");
    final newMatches = json.decode(myJson);
    print("${newMatches.length} new matches");
    print(newMatches.toString());
    /// Prevent duplicates
    Set<String> matchesSet = {};
    oldMatches.forEach((element) {
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
}
