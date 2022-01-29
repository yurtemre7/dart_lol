import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class LolStorage {
  final summonerStorage = new LocalStorage('summoners');
  final matchHistoryStorage = new LocalStorage('match_histories');
  final matchStorage = new LocalStorage('matches');

  Map<String, dynamic> getSummoner(String summonerName) {
    return json.decode(summonerStorage.getItem(summonerName));
  }

  saveSummoner(String summonerName, String summonerJson) {
    summonerStorage.setItem(summonerName, summonerJson);
  }

  Map<String, dynamic> getMatch(String matchId) {
    final matchString = matchStorage.getItem("$matchId");
    if(matchString == null)
      return {};
    else return json.decode(matchString);
  }

  saveMatch(String matchId, String matchJson) {
    matchStorage.setItem(matchId, matchJson);
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
    final newMatches = json.decode(myJson);
    print("${newMatches.length} new matches");
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
