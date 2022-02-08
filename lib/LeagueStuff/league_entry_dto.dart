// To parse this JSON data, do
//
//     final leagueEntryDto = leagueEntryDtoFromJson(jsonString);

import 'dart:convert';

List<LeagueEntryDto> leagueEntryDtoFromJson(String str) => List<LeagueEntryDto>.from(json.decode(str).map((x) => LeagueEntryDto.fromJson(x)));

String leagueEntryDtoToJson(List<LeagueEntryDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeagueEntryDto {
  LeagueEntryDto({
    this.leagueId,
    this.queueType,
    this.tier,
    this.rank,
    this.summonerId,
    this.summonerName,
    this.leaguePoints,
    this.wins,
    this.losses,
    this.veteran,
    this.inactive,
    this.freshBlood,
    this.hotStreak,
  });

  final String? leagueId;
  final String? queueType;
  final String? tier;
  final String? rank;
  final String? summonerId;
  final String? summonerName;
  final int? leaguePoints;
  final int? wins;
  final int? losses;
  final bool? veteran;
  final bool? inactive;
  final bool? freshBlood;
  final bool? hotStreak;

  factory LeagueEntryDto.fromJson(Map<String, dynamic> json) => LeagueEntryDto(
    leagueId: json["leagueId"],
    queueType: json["queueType"],
    tier: json["tier"],
    rank: json["rank"],
    summonerId: json["summonerId"],
    summonerName: json["summonerName"],
    leaguePoints: json["leaguePoints"],
    wins: json["wins"],
    losses: json["losses"],
    veteran: json["veteran"],
    inactive: json["inactive"],
    freshBlood: json["freshBlood"],
    hotStreak: json["hotStreak"],
  );

  Map<String, dynamic> toJson() => {
    "leagueId": leagueId,
    "queueType": queueType,
    "tier": tier,
    "rank": rank,
    "summonerId": summonerId,
    "summonerName": summonerName,
    "leaguePoints": leaguePoints,
    "wins": wins,
    "losses": losses,
    "veteran": veteran,
    "inactive": inactive,
    "freshBlood": freshBlood,
    "hotStreak": hotStreak,
  };
}
