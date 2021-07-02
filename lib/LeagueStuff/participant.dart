class Participant {
  final String? summonerName;
  final String? summonerID;
  final int? teamID;
  final String? championName;
  final bool? win;
  final int? kills;
  final int? deaths;
  final int? assists;
  final int? csScore;
  final List<int?>? items;

  /// A Summoner() instance to use to create a
  /// custom summoner or use it with the League()
  /// instance to get real-time information.
  Participant({
    this.summonerName,
    this.summonerID,
    this.teamID,
    this.championName,
    this.win,
    this.kills,
    this.deaths,
    this.assists,
    this.csScore,
    this.items,
  });
}
