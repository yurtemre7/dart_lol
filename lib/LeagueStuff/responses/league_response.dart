import '../summoner.dart';
import 'package:dart_lol/LeagueStuff/match.dart';

class LeagueResponse {
  final int? responseCode;
  final String? responseMessage;
  final int? retryTimestamp;

  final double? appCurrentRateLimitPercentage;
  final double? headerCurrentRateLimitPercentage;

  final Summoner? summoner;
  final List<dynamic>? matchOverviews;
  final Match? match;

  LeagueResponse({
    this.responseCode,
    this.responseMessage,
    this.retryTimestamp,
    this.appCurrentRateLimitPercentage,
    this.headerCurrentRateLimitPercentage,
    this.summoner,
    this.matchOverviews,
    this.match});
}