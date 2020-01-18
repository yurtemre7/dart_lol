import 'package:dart_lol/LeagueStuff/participant.dart';

import 'champ_names.dart';

class GameStat {
  final int gameCreation;
  final int gameDuration;
  final bool win;
  final int seasonID;
  final String gameMode;

  /// This list contains a Participant() Instance List with the number of actual players in a game.
  /// e.g. in a ranked game it would be 10 long (0-9).
  final List<Participant> participants;
  //[participantId] and [stats][kills]or[deaths]or[assists]
  //and [timeline][role]or[lane]

  /// A GameStat() instance to use to create a
  /// custom GameStats or use it with the League()
  /// instance to get the latest Game statistics.
  GameStat(
      {this.gameCreation,
      this.gameDuration,
      this.seasonID,
      this.win,
      this.gameMode,
      this.participants});

  factory GameStat.fromJson(Map<String, dynamic> json, name) {
    return GameStat(
      gameCreation: json['gameCreation'],
      gameDuration: json['gameDuration'],
      win: _teamIdFinder(json['teams'], json['participantIdentities'],
          json['participants'], name),
      seasonID: json['seasonId'],
      participants:
          _getParticipants(json['participantIdentities'], json['participants']),
    );
  }
}

_teamIdFinder(List teams, list1, list2, name) {
  bool won = false;
  List<Participant> players = _getParticipants(list1, list2);
  players.forEach((player){
    if (player.championName == name){
      won = player.win;
    }
  });
  return won;
}

List<Participant> _getParticipants(List<dynamic> names, List<dynamic> infos) {
  List<Participant> participant = [];
  Participant part;
  names.forEach((info) {
    var index = names.indexOf(info);
    part = Participant(
      summonerName: info['player']['summonerName'],
      summonerID: info['player']['summonerId'],
      teamID: infos[index]['teamId'],
      championName: getChampNameByID(infos[index]['championId']),
      win: infos[index]['stats']['win'],
      kills: infos[index]['stats']['kills'],
      deaths: infos[index]['stats']['deaths'],
      assists: infos[index]['stats']['deaths'],
      csScore: infos[index]['stats']['totalMinionsKilled'] +
          infos[index]['stats']['neutralMinionsKilled'],
    );
    participant.add(part);
  });

  return participant;
}
