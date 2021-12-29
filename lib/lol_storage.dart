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

  // List<String> getMatchHistories(String puuid) {
  //
  // }

  saveMatchHistories(String key, String json) {
    matchHistoryStorage.setItem(key, json);
  }
}
