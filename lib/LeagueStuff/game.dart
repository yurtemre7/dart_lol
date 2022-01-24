import 'dart:convert';

import 'champ_names.dart';
import 'game_stats.dart';
import 'package:http/http.dart' as http;

class Game {
  final String? lane;
  final int? gameID;
  final int? championID;
  final String? summonerName;
  final int? time;
  final String? championName;
  final Future<GameStat>? gameStat;
  final String? apiToken;
  final String? server;

  /// A Game() instance to use to create a
  /// custom Game or use it with the League()
  /// instance to get the latest Game information.
  Game({
    this.lane,
    this.gameID,
    this.championID,
    this.time,
    this.summonerName,
    this.championName,
    this.gameStat,
    this.apiToken,
    this.server,
  });

  factory Game.fromJson(Map<String, dynamic> json, String apiToken, String? summonerName, String? server) {
    return Game(
      lane: json['lane'],
      gameID: json['gameId'],
      championID: json['champion'],
      time: json['timestamp'],
      championName: getChampNameByID(
        json['champion'],
      ),
      summonerName: summonerName,
      apiToken: apiToken,
      server: server,
    );
  }

  ///
  Future<GameStat> stats() async {
    var url = 'https://$server.api.riotgames.com/lol/match/v4/matches/${this.gameID}?api_key=$apiToken';
    var response = await http.get(
      Uri.parse(url),
    );
    final match = json.decode(response.body);
    //print(matchList);

    return GameStat.fromJson(json.decode(json.encode(match)), this.championName, this.summonerName);
  }
}
