class Summoner {
  String? id;
  String? accountId;
  String? puuid;
  String? name;
  int? profileIconId;
  int? revisionDate;
  int? summonerLevel;
  List<String>? matches;

  Summoner(
      {this.id,
      this.accountId,
      this.puuid,
      this.name,
      this.profileIconId,
      this.revisionDate,
      this.summonerLevel,
      this.matches});

  Summoner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    puuid = json['puuid'];
    name = json['name'];
    profileIconId = json['profileIconId'];
    revisionDate = json['revisionDate'];
    summonerLevel = json['summonerLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accountId'] = accountId;
    data['puuid'] = puuid;
    data['name'] = name;
    data['profileIconId'] = profileIconId;
    data['revisionDate'] = revisionDate;
    data['summonerLevel'] = summonerLevel;
    data['matches'] = matches;
    return data;
  }
}
