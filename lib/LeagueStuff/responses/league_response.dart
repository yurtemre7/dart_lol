import 'package:dart_lol/LeagueStuff/league_entry_dto.dart';

import '../summoner.dart';
import 'package:dart_lol/LeagueStuff/match.dart';

class LeagueResponse {
  final int? responseCode;
  final int? retryTimestamp;

  final double? appCurrentRateLimitPercentage;
  final double? headerCurrentRateLimitPercentage;

  final Summoner? summoner;
  List<String>? matchOverviews;
  final Match? match;
  final LeagueEntryDto? leagueEntryDto;
  final List<LeagueEntryDto>? rankedPlayers;

  LeagueResponse({
    this.responseCode,
    this.retryTimestamp,
    this.appCurrentRateLimitPercentage,
    this.headerCurrentRateLimitPercentage,
    this.summoner,
    this.matchOverviews,
    this.match,
    this.leagueEntryDto,
    this.rankedPlayers});
}