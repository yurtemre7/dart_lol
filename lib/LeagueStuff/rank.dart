class Rank {
  final bool hotStreak;
  final int wins;
  final int losses;
  final String rank;
  final String leagueId;
  final String tier;
  final int leaguePoints;

  /// A Rank() instance to use to create a
  /// custom summoner or use it with the League()
  /// instance to get rank information.
  Rank({
    this.hotStreak,
    this.wins,
    this.losses,
    this.rank,
    this.leagueId,
    this.tier,
    this.leaguePoints,
  });

  factory Rank.fromJson(Map<String, dynamic> json) {
    return Rank(
      hotStreak: json['hotStreak'],
      wins: json['wins'],
      losses: json['losses'],
      rank: json['rank'],
      leagueId: json['leagueId'],
      tier: json['tier'],
      leaguePoints: json['leaguePoints'],
    );
  }
}
