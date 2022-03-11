import 'package:dart_lol/LeagueStuff/league_entry_dto.dart';
import 'package:dart_lol/LeagueStuff/responses/league_response.dart';
import 'package:dio/dio.dart';
import 'LeagueStuff/responses/league_response.dart';
import 'LeagueStuff/summoner.dart';
import 'package:dart_lol/LeagueStuff/match.dart';

import 'dart_lol_db.dart';

class RateLimiter extends DbStore {

  List apiCalls = [];
  /// App Rate Limit
  int appMaxCallsPerSecond = 20;
  int appMaxCallsPerTwoMinutes = 100;
  int appLowerCurrent = 0;
  int appUpperCurrent = 0;
  /// Header Rate Limit
  int lastCheckedHeaders = 0;
  int headerMaxCallsPerSecond = 20;
  int headerMaxCallsPerTwoMinutes = 100;
  int headerLowerCurrent = 0;
  int headerUpperCurrent = 0;

  LeagueResponse returnLeagueResponse({
    int? responseCode = 200,
    int? retryTimestamp = 0,
    Summoner? summoner,
    List<String>? matchOverviews,
    Match? match,
    LeagueEntryDto? rankedEntryDTO,
    List<LeagueEntryDto>? rankedPlayers}) {
    return LeagueResponse(
      responseCode: responseCode,
      retryTimestamp: retryTimestamp,
      appCurrentRateLimitPercentage: appUpperCurrent/appMaxCallsPerTwoMinutes,
      headerCurrentRateLimitPercentage: headerUpperCurrent/headerMaxCallsPerTwoMinutes,

      summoner: summoner,
      matchOverviews: matchOverviews,
      match: match,
      leagueEntryDto: rankedEntryDTO,
      rankedPlayers: rankedPlayers
    );
  }

  bool passesHeaderRateLimit(int now) {
    final twoMinutesAgo = now - 120000;
    //check if headers are older than 2 minutes
    if(twoMinutesAgo > lastCheckedHeaders)
      return true;
    //check if we're maxing out the rate limit
    final lowerRatio = (appLowerCurrent.toDouble() / appMaxCallsPerSecond.toDouble())*100;
    print("Lower Ratio: $lowerRatio");
    final upperRatio = (appUpperCurrent.toDouble() / appMaxCallsPerTwoMinutes.toDouble())*100;
    print("$appUpperCurrent and $appMaxCallsPerTwoMinutes");
    print("Upper Ratio: $upperRatio");
    if(lowerRatio > 95.0 || upperRatio > 95.0)
      return false;
    return true;
  }

  void updateHeaders(Map<String, String> headers) {
    try {
      //allowed max
      //
      final rateLimit = headers["x-app-rate-limit"];
      final rateLimitSplit = rateLimit?.split(",");
      //lower max
      final lowerLimitSplit = rateLimitSplit?[0].split(":");
      final maybeTwenty = lowerLimitSplit?[0];
      final lowerMaxCalls = int.parse(maybeTwenty.toString());
      final maybeOneSecond = lowerLimitSplit?[1];
      final lowerMaxSeconds = int.parse(maybeOneSecond.toString());
      //upper max
      final upperLimitSplit = rateLimitSplit?[1].split(":");
      final maybeOneHundred = upperLimitSplit?[0];
      final upperMaxCalls = int.parse(maybeOneHundred.toString());
      final maybeOneTwenty = upperLimitSplit?[1];
      final upperMaxSeconds = int.parse(maybeOneTwenty.toString());
      //current max
      //
      final rateLimitCount = headers["x-app-rate-limit-count"];
      final rateLimitCountSplit = rateLimitCount?.split(",");
      //lower max current
      final lowerCountSplit = rateLimitCountSplit?[0].split(":");
      final maybeOne = lowerCountSplit?[0];
      final lowerCount = int.parse(maybeOne.toString());
      //upper max current
      final upperCountSplit = rateLimitCountSplit?[1].split(":");
      final maybeOneAgain = upperCountSplit?[0];
      final upperCount = int.parse(maybeOneAgain.toString());

      print("lower: $lowerCount/$lowerMaxCalls every $lowerMaxSeconds second");
      print("upper: $upperCount/$upperMaxCalls every $upperMaxSeconds seconds");
      appLowerCurrent = lowerCount;
      appUpperCurrent = upperCount;
      lastCheckedHeaders = DateTime.now().millisecondsSinceEpoch;
    } catch(e) {
      print("Caught Exception parsing riot headers: ${e.toString()} ");
    }
  }

  bool passesApiCallsRateLimit(int now) {
    print("We have made ${apiCalls.length} api calls");
    final twoMinutesAgo = now - 120000;
    final listSinceTwoMinutes = apiCalls.where((element) => element > twoMinutesAgo).toList();
    print("We have made ${listSinceTwoMinutes.length} api calls within the past 2 minutes");
    if(listSinceTwoMinutes.length >= appMaxCallsPerTwoMinutes)
      return false;
    return true;
  }
}
