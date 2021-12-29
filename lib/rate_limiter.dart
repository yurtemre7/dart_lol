class RateLimiter {

  ///Rate limit stuff
  int lastCheckedHeaders = 0;
  int rateLimitLowerMax = 20;
  int rateLimitUpperMax = 100;
  int rateLimitLowerCurrent = 0;
  int rateLimitUpperCurrent = 0;
  List apiCalls = [];

  bool passesHeaderRateLimit(int now) {
    final twoMinutesAgo = now - 120000;
    //check if headers are older than 2 minutes
    if(twoMinutesAgo > lastCheckedHeaders)
      return true;
    //check if we're maxing out the rate limit
    final lowerRatio = (rateLimitLowerCurrent.toDouble() / rateLimitLowerMax.toDouble())*100;
    print("Lower Ratio: $lowerRatio");
    final upperRatio = (rateLimitUpperCurrent.toDouble() / rateLimitUpperMax.toDouble())*100;
    print("$rateLimitUpperCurrent and $rateLimitUpperMax");
    print("Upper Ratio: $upperRatio");
    if(lowerRatio > 95.0 || upperRatio > 95.0)
      return false;
    return true;
  }

  void updateHeaders(Map<String, String> headers) {
    print(headers.toString());
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
      rateLimitLowerCurrent = lowerCount;
      rateLimitUpperCurrent = upperCount;
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
    if(listSinceTwoMinutes.length >= rateLimitUpperMax)
      return false;
    return true;
  }
}
