import 'dart:convert';

import 'champ_names.dart';
import 'game_stats.dart';
import 'package:http/http.dart' as http;

class Game {
  final String lane;
  final int gameID;
  final int championID;
  final int time;
  final String championName;
  final Future<GameStat> gameStat;
  final String apiToken;

  /// A Game() instance to use to create a
  /// custom Game or use it with the League()
  /// instance to get the latest Game information.
  Game(
      {this.lane,
      this.gameID,
      this.championID,
      this.time,
      this.championName,
      this.gameStat,
      this.apiToken});

  factory Game.fromJson(Map<String, dynamic> json, String apiToken) {
    return Game(
      lane: json['lane'],
      gameID: json['gameId'],
      championID: json['champion'],
      time: json['timestamp'],
      championName: getChampNameByID(
        json['champion'],
      ),
      apiToken: apiToken,
    );
  }

  /// Needs a String gameID which you can easily get from the Game().gameID.
  Future<GameStat> stats() async {
    var url =
        'https://euw1.api.riotgames.com/lol/match/v4/matches/${this.gameID}?api_key=$apiToken';
    var response = await http.get(
      url,
    );
    final matchList = json.decode(response.body);
    //print(matchList);

    return GameStat.fromJson(
      json.decode(json.encode(matchList)),
    );
  }
}
