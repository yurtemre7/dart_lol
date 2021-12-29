class LeagueResponse {
  final int? responseCode;
  final String? responseMessage;
  final int? retryTimestamp;
  final String? appRateLimit;
  final String? appRateLimitCount;

  LeagueResponse({this.responseCode, this.responseMessage, this.retryTimestamp, this.appRateLimit, this.appRateLimitCount});
}