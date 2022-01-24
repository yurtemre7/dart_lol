class Summoner {
  final String? summonerName;
  final int? level;
  final String? accID;
  final String? summonerID;
  final DateTime? lastTimeOnline;
  final int? profileIconID;
  final String? puuid;

  /// A Summoner() instance to use to create a
  /// custom summoner or use it with the League()
  /// instance to get real-time information.
  Summoner({
    this.summonerName,
    this.level,
    this.accID,
    this.summonerID,
    this.lastTimeOnline,
    this.puuid,
    this.profileIconID,
  });

  factory Summoner.fromJson(Map<String, dynamic> json) {
    return Summoner(
      summonerName: json['name'],
      level: json['summonerLevel'],
      summonerID: json['id'],
      accID: json['accountId'],
      lastTimeOnline: DateTime.fromMillisecondsSinceEpoch(json['revisionDate']),
      puuid: json['puuid'],
      profileIconID: json['profileIconId'],
    );
  }
}
