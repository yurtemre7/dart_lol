import 'package:dart_lol/LeagueStuff/match.dart';
class Summoner {
  String? id;
  String? accountId;
  String? puuid;
  String? name;
  int? profileIconId;
  int? revisionDate;
  int? summonerLevel;
  List<String>? matchHistories = <String>[];
  List<Match>? matches = <Match>[];
  bool? isFavorite = false;

  Summoner(
      {this.id,
        this.accountId,
        this.puuid,
        this.name,
        this.profileIconId,
        this.revisionDate,
        this.summonerLevel,
        this.matchHistories,
        this.matches,
        this.isFavorite = false});

  Summoner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    puuid = json['puuid'];
    name = json['name'];
    profileIconId = json['profileIconId'];
    revisionDate = json['revisionDate'];
    summonerLevel = json['summonerLevel'];
    matches = json['matches'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accountId'] = this.accountId;
    data['puuid'] = this.puuid;
    data['name'] = this.name;
    data['profileIconId'] = this.profileIconId;
    data['revisionDate'] = this.revisionDate;
    data['summonerLevel'] = this.summonerLevel;
    data['matchHistories'] = this.matchHistories;
    data['matches'] = this.matches;
    data['isFavorite'] = this.isFavorite;
    return data;
  }
}
