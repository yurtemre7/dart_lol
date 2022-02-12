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

  LeagueResponse({
    this.responseCode,
    this.retryTimestamp,
    this.appCurrentRateLimitPercentage,
    this.headerCurrentRateLimitPercentage,
    this.summoner,
    this.matchOverviews,
    this.match,
  });
}
