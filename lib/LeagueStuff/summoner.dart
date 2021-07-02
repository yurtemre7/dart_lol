class Summoner {
  final String? summonerName;
  final int? level;
  final String? accID;
  final String? summonerID;
  final int? lastTimeOnline;

  /// A Summoner() instance to use to create a
  /// custom summoner or use it with the League()
  /// instance to get real-time information.
  Summoner({
    this.summonerName,
    this.level,
    this.accID,
    this.summonerID,
    this.lastTimeOnline,
  });

  factory Summoner.fromJson(Map<String, dynamic> json) {
    return Summoner(
      summonerName: json['name'],
      level: json['summonerLevel'],
      summonerID: json['id'],
      accID: json['accountId'],
      lastTimeOnline: json['revisionDate'],
    );
  }
}
