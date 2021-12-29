class Match {
  Metadata? metadata;
  Info? info;

  Match({this.metadata, this.info});

  Match.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    return data;
  }
}

class Metadata {
  String? dataVersion;
  String? matchId;
  List<String>? participants;

  Metadata({this.dataVersion, this.matchId, this.participants});

  Metadata.fromJson(Map<String, dynamic> json) {
    dataVersion = json['dataVersion'];
    matchId = json['matchId'];
    participants = json['participants'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataVersion'] = this.dataVersion;
    data['matchId'] = this.matchId;
    data['participants'] = this.participants;
    return data;
  }
}

class Info {
  int? gameCreation;
  int? gameDuration;
  int? gameId;
  String? gameMode;
  String? gameName;
  int? gameStartTimestamp;
  String? gameType;
  String? gameVersion;
  int? mapId;
  List<Participants>? participants;
  String? platformId;
  int? queueId;
  List<Teams>? teams;
  String? tournamentCode;

  Info(
      {this.gameCreation,
        this.gameDuration,
        this.gameId,
        this.gameMode,
        this.gameName,
        this.gameStartTimestamp,
        this.gameType,
        this.gameVersion,
        this.mapId,
        this.participants,
        this.platformId,
        this.queueId,
        this.teams,
        this.tournamentCode});

  Info.fromJson(Map<String, dynamic> json) {
    gameCreation = json['gameCreation'];
    gameDuration = json['gameDuration'];
    gameId = json['gameId'];
    gameMode = json['gameMode'];
    gameName = json['gameName'];
    gameStartTimestamp = json['gameStartTimestamp'];
    gameType = json['gameType'];
    gameVersion = json['gameVersion'];
    mapId = json['mapId'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
    platformId = json['platformId'];
    queueId = json['queueId'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(new Teams.fromJson(v));
      });
    }
    tournamentCode = json['tournamentCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gameCreation'] = this.gameCreation;
    data['gameDuration'] = this.gameDuration;
    data['gameId'] = this.gameId;
    data['gameMode'] = this.gameMode;
    data['gameName'] = this.gameName;
    data['gameStartTimestamp'] = this.gameStartTimestamp;
    data['gameType'] = this.gameType;
    data['gameVersion'] = this.gameVersion;
    data['mapId'] = this.mapId;
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    data['platformId'] = this.platformId;
    data['queueId'] = this.queueId;
    if (this.teams != null) {
      data['teams'] = this.teams!.map((v) => v.toJson()).toList();
    }
    data['tournamentCode'] = this.tournamentCode;
    return data;
  }
}

class Participants {
  int? assists;
  int? baronKills;
  int? bountyLevel;
  int? champExperience;
  int? champLevel;
  int? championId;
  String? championName;
  int? championTransform;
  int? consumablesPurchased;
  int? damageDealtToBuildings;
  int? damageDealtToObjectives;
  int? damageDealtToTurrets;
  int? damageSelfMitigated;
  int? deaths;
  int? detectorWardsPlaced;
  int? doubleKills;
  int? dragonKills;
  bool? firstBloodAssist;
  bool? firstBloodKill;
  bool? firstTowerAssist;
  bool? firstTowerKill;
  bool? gameEndedInEarlySurrender;
  bool? gameEndedInSurrender;
  int? goldEarned;
  int? goldSpent;
  String? individualPosition;
  int? inhibitorKills;
  int? inhibitorTakedowns;
  int? inhibitorsLost;
  int? item0;
  int? item1;
  int? item2;
  int? item3;
  int? item4;
  int? item5;
  int? item6;
  int? itemsPurchased;
  int? killingSprees;
  int? kills;
  String? lane;
  int? largestCriticalStrike;
  int? largestKillingSpree;
  int? largestMultiKill;
  int? longestTimeSpentLiving;
  int? magicDamageDealt;
  int? magicDamageDealtToChampions;
  int? magicDamageTaken;
  int? neutralMinionsKilled;
  int? nexusKills;
  int? nexusLost;
  int? nexusTakedowns;
  int? objectivesStolen;
  int? objectivesStolenAssists;
  int? participantId;
  int? pentaKills;
  Perks? perks;
  int? physicalDamageDealt;
  int? physicalDamageDealtToChampions;
  int? physicalDamageTaken;
  int? profileIcon;
  String? puuid;
  int? quadraKills;
  String? riotIdName;
  String? riotIdTagline;
  String? role;
  int? sightWardsBoughtInGame;
  int? spell1Casts;
  int? spell2Casts;
  int? spell3Casts;
  int? spell4Casts;
  int? summoner1Casts;
  int? summoner1Id;
  int? summoner2Casts;
  int? summoner2Id;
  String? summonerId;
  int? summonerLevel;
  String? summonerName;
  bool? teamEarlySurrendered;
  int? teamId;
  String? teamPosition;
  int? timeCCingOthers;
  int? timePlayed;
  int? totalDamageDealt;
  int? totalDamageDealtToChampions;
  int? totalDamageShieldedOnTeammates;
  int? totalDamageTaken;
  int? totalHeal;
  int? totalHealsOnTeammates;
  int? totalMinionsKilled;
  int? totalTimeCCDealt;
  int? totalTimeSpentDead;
  int? totalUnitsHealed;
  int? tripleKills;
  int? trueDamageDealt;
  int? trueDamageDealtToChampions;
  int? trueDamageTaken;
  int? turretKills;
  int? turretTakedowns;
  int? turretsLost;
  int? unrealKills;
  int? visionScore;
  int? visionWardsBoughtInGame;
  int? wardsKilled;
  int? wardsPlaced;
  bool? win;

  Participants(
      {this.assists,
        this.baronKills,
        this.bountyLevel,
        this.champExperience,
        this.champLevel,
        this.championId,
        this.championName,
        this.championTransform,
        this.consumablesPurchased,
        this.damageDealtToBuildings,
        this.damageDealtToObjectives,
        this.damageDealtToTurrets,
        this.damageSelfMitigated,
        this.deaths,
        this.detectorWardsPlaced,
        this.doubleKills,
        this.dragonKills,
        this.firstBloodAssist,
        this.firstBloodKill,
        this.firstTowerAssist,
        this.firstTowerKill,
        this.gameEndedInEarlySurrender,
        this.gameEndedInSurrender,
        this.goldEarned,
        this.goldSpent,
        this.individualPosition,
        this.inhibitorKills,
        this.inhibitorTakedowns,
        this.inhibitorsLost,
        this.item0,
        this.item1,
        this.item2,
        this.item3,
        this.item4,
        this.item5,
        this.item6,
        this.itemsPurchased,
        this.killingSprees,
        this.kills,
        this.lane,
        this.largestCriticalStrike,
        this.largestKillingSpree,
        this.largestMultiKill,
        this.longestTimeSpentLiving,
        this.magicDamageDealt,
        this.magicDamageDealtToChampions,
        this.magicDamageTaken,
        this.neutralMinionsKilled,
        this.nexusKills,
        this.nexusLost,
        this.nexusTakedowns,
        this.objectivesStolen,
        this.objectivesStolenAssists,
        this.participantId,
        this.pentaKills,
        this.perks,
        this.physicalDamageDealt,
        this.physicalDamageDealtToChampions,
        this.physicalDamageTaken,
        this.profileIcon,
        this.puuid,
        this.quadraKills,
        this.riotIdName,
        this.riotIdTagline,
        this.role,
        this.sightWardsBoughtInGame,
        this.spell1Casts,
        this.spell2Casts,
        this.spell3Casts,
        this.spell4Casts,
        this.summoner1Casts,
        this.summoner1Id,
        this.summoner2Casts,
        this.summoner2Id,
        this.summonerId,
        this.summonerLevel,
        this.summonerName,
        this.teamEarlySurrendered,
        this.teamId,
        this.teamPosition,
        this.timeCCingOthers,
        this.timePlayed,
        this.totalDamageDealt,
        this.totalDamageDealtToChampions,
        this.totalDamageShieldedOnTeammates,
        this.totalDamageTaken,
        this.totalHeal,
        this.totalHealsOnTeammates,
        this.totalMinionsKilled,
        this.totalTimeCCDealt,
        this.totalTimeSpentDead,
        this.totalUnitsHealed,
        this.tripleKills,
        this.trueDamageDealt,
        this.trueDamageDealtToChampions,
        this.trueDamageTaken,
        this.turretKills,
        this.turretTakedowns,
        this.turretsLost,
        this.unrealKills,
        this.visionScore,
        this.visionWardsBoughtInGame,
        this.wardsKilled,
        this.wardsPlaced,
        this.win});

  Participants.fromJson(Map<String, dynamic> json) {
    assists = json['assists'];
    baronKills = json['baronKills'];
    bountyLevel = json['bountyLevel'];
    champExperience = json['champExperience'];
    champLevel = json['champLevel'];
    championId = json['championId'];
    championName = json['championName'];
    championTransform = json['championTransform'];
    consumablesPurchased = json['consumablesPurchased'];
    damageDealtToBuildings = json['damageDealtToBuildings'];
    damageDealtToObjectives = json['damageDealtToObjectives'];
    damageDealtToTurrets = json['damageDealtToTurrets'];
    damageSelfMitigated = json['damageSelfMitigated'];
    deaths = json['deaths'];
    detectorWardsPlaced = json['detectorWardsPlaced'];
    doubleKills = json['doubleKills'];
    dragonKills = json['dragonKills'];
    firstBloodAssist = json['firstBloodAssist'];
    firstBloodKill = json['firstBloodKill'];
    firstTowerAssist = json['firstTowerAssist'];
    firstTowerKill = json['firstTowerKill'];
    gameEndedInEarlySurrender = json['gameEndedInEarlySurrender'];
    gameEndedInSurrender = json['gameEndedInSurrender'];
    goldEarned = json['goldEarned'];
    goldSpent = json['goldSpent'];
    individualPosition = json['individualPosition'];
    inhibitorKills = json['inhibitorKills'];
    inhibitorTakedowns = json['inhibitorTakedowns'];
    inhibitorsLost = json['inhibitorsLost'];
    item0 = json['item0'];
    item1 = json['item1'];
    item2 = json['item2'];
    item3 = json['item3'];
    item4 = json['item4'];
    item5 = json['item5'];
    item6 = json['item6'];
    itemsPurchased = json['itemsPurchased'];
    killingSprees = json['killingSprees'];
    kills = json['kills'];
    lane = json['lane'];
    largestCriticalStrike = json['largestCriticalStrike'];
    largestKillingSpree = json['largestKillingSpree'];
    largestMultiKill = json['largestMultiKill'];
    longestTimeSpentLiving = json['longestTimeSpentLiving'];
    magicDamageDealt = json['magicDamageDealt'];
    magicDamageDealtToChampions = json['magicDamageDealtToChampions'];
    magicDamageTaken = json['magicDamageTaken'];
    neutralMinionsKilled = json['neutralMinionsKilled'];
    nexusKills = json['nexusKills'];
    nexusLost = json['nexusLost'];
    nexusTakedowns = json['nexusTakedowns'];
    objectivesStolen = json['objectivesStolen'];
    objectivesStolenAssists = json['objectivesStolenAssists'];
    participantId = json['participantId'];
    pentaKills = json['pentaKills'];
    perks = json['perks'] != null ? new Perks.fromJson(json['perks']) : null;
    physicalDamageDealt = json['physicalDamageDealt'];
    physicalDamageDealtToChampions = json['physicalDamageDealtToChampions'];
    physicalDamageTaken = json['physicalDamageTaken'];
    profileIcon = json['profileIcon'];
    puuid = json['puuid'];
    quadraKills = json['quadraKills'];
    riotIdName = json['riotIdName'];
    riotIdTagline = json['riotIdTagline'];
    role = json['role'];
    sightWardsBoughtInGame = json['sightWardsBoughtInGame'];
    spell1Casts = json['spell1Casts'];
    spell2Casts = json['spell2Casts'];
    spell3Casts = json['spell3Casts'];
    spell4Casts = json['spell4Casts'];
    summoner1Casts = json['summoner1Casts'];
    summoner1Id = json['summoner1Id'];
    summoner2Casts = json['summoner2Casts'];
    summoner2Id = json['summoner2Id'];
    summonerId = json['summonerId'];
    summonerLevel = json['summonerLevel'];
    summonerName = json['summonerName'];
    teamEarlySurrendered = json['teamEarlySurrendered'];
    teamId = json['teamId'];
    teamPosition = json['teamPosition'];
    timeCCingOthers = json['timeCCingOthers'];
    timePlayed = json['timePlayed'];
    totalDamageDealt = json['totalDamageDealt'];
    totalDamageDealtToChampions = json['totalDamageDealtToChampions'];
    totalDamageShieldedOnTeammates = json['totalDamageShieldedOnTeammates'];
    totalDamageTaken = json['totalDamageTaken'];
    totalHeal = json['totalHeal'];
    totalHealsOnTeammates = json['totalHealsOnTeammates'];
    totalMinionsKilled = json['totalMinionsKilled'];
    totalTimeCCDealt = json['totalTimeCCDealt'];
    totalTimeSpentDead = json['totalTimeSpentDead'];
    totalUnitsHealed = json['totalUnitsHealed'];
    tripleKills = json['tripleKills'];
    trueDamageDealt = json['trueDamageDealt'];
    trueDamageDealtToChampions = json['trueDamageDealtToChampions'];
    trueDamageTaken = json['trueDamageTaken'];
    turretKills = json['turretKills'];
    turretTakedowns = json['turretTakedowns'];
    turretsLost = json['turretsLost'];
    unrealKills = json['unrealKills'];
    visionScore = json['visionScore'];
    visionWardsBoughtInGame = json['visionWardsBoughtInGame'];
    wardsKilled = json['wardsKilled'];
    wardsPlaced = json['wardsPlaced'];
    win = json['win'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assists'] = this.assists;
    data['baronKills'] = this.baronKills;
    data['bountyLevel'] = this.bountyLevel;
    data['champExperience'] = this.champExperience;
    data['champLevel'] = this.champLevel;
    data['championId'] = this.championId;
    data['championName'] = this.championName;
    data['championTransform'] = this.championTransform;
    data['consumablesPurchased'] = this.consumablesPurchased;
    data['damageDealtToBuildings'] = this.damageDealtToBuildings;
    data['damageDealtToObjectives'] = this.damageDealtToObjectives;
    data['damageDealtToTurrets'] = this.damageDealtToTurrets;
    data['damageSelfMitigated'] = this.damageSelfMitigated;
    data['deaths'] = this.deaths;
    data['detectorWardsPlaced'] = this.detectorWardsPlaced;
    data['doubleKills'] = this.doubleKills;
    data['dragonKills'] = this.dragonKills;
    data['firstBloodAssist'] = this.firstBloodAssist;
    data['firstBloodKill'] = this.firstBloodKill;
    data['firstTowerAssist'] = this.firstTowerAssist;
    data['firstTowerKill'] = this.firstTowerKill;
    data['gameEndedInEarlySurrender'] = this.gameEndedInEarlySurrender;
    data['gameEndedInSurrender'] = this.gameEndedInSurrender;
    data['goldEarned'] = this.goldEarned;
    data['goldSpent'] = this.goldSpent;
    data['individualPosition'] = this.individualPosition;
    data['inhibitorKills'] = this.inhibitorKills;
    data['inhibitorTakedowns'] = this.inhibitorTakedowns;
    data['inhibitorsLost'] = this.inhibitorsLost;
    data['item0'] = this.item0;
    data['item1'] = this.item1;
    data['item2'] = this.item2;
    data['item3'] = this.item3;
    data['item4'] = this.item4;
    data['item5'] = this.item5;
    data['item6'] = this.item6;
    data['itemsPurchased'] = this.itemsPurchased;
    data['killingSprees'] = this.killingSprees;
    data['kills'] = this.kills;
    data['lane'] = this.lane;
    data['largestCriticalStrike'] = this.largestCriticalStrike;
    data['largestKillingSpree'] = this.largestKillingSpree;
    data['largestMultiKill'] = this.largestMultiKill;
    data['longestTimeSpentLiving'] = this.longestTimeSpentLiving;
    data['magicDamageDealt'] = this.magicDamageDealt;
    data['magicDamageDealtToChampions'] = this.magicDamageDealtToChampions;
    data['magicDamageTaken'] = this.magicDamageTaken;
    data['neutralMinionsKilled'] = this.neutralMinionsKilled;
    data['nexusKills'] = this.nexusKills;
    data['nexusLost'] = this.nexusLost;
    data['nexusTakedowns'] = this.nexusTakedowns;
    data['objectivesStolen'] = this.objectivesStolen;
    data['objectivesStolenAssists'] = this.objectivesStolenAssists;
    data['participantId'] = this.participantId;
    data['pentaKills'] = this.pentaKills;
    if (this.perks != null) {
      data['perks'] = this.perks?.toJson();
    }
    data['physicalDamageDealt'] = this.physicalDamageDealt;
    data['physicalDamageDealtToChampions'] =
        this.physicalDamageDealtToChampions;
    data['physicalDamageTaken'] = this.physicalDamageTaken;
    data['profileIcon'] = this.profileIcon;
    data['puuid'] = this.puuid;
    data['quadraKills'] = this.quadraKills;
    data['riotIdName'] = this.riotIdName;
    data['riotIdTagline'] = this.riotIdTagline;
    data['role'] = this.role;
    data['sightWardsBoughtInGame'] = this.sightWardsBoughtInGame;
    data['spell1Casts'] = this.spell1Casts;
    data['spell2Casts'] = this.spell2Casts;
    data['spell3Casts'] = this.spell3Casts;
    data['spell4Casts'] = this.spell4Casts;
    data['summoner1Casts'] = this.summoner1Casts;
    data['summoner1Id'] = this.summoner1Id;
    data['summoner2Casts'] = this.summoner2Casts;
    data['summoner2Id'] = this.summoner2Id;
    data['summonerId'] = this.summonerId;
    data['summonerLevel'] = this.summonerLevel;
    data['summonerName'] = this.summonerName;
    data['teamEarlySurrendered'] = this.teamEarlySurrendered;
    data['teamId'] = this.teamId;
    data['teamPosition'] = this.teamPosition;
    data['timeCCingOthers'] = this.timeCCingOthers;
    data['timePlayed'] = this.timePlayed;
    data['totalDamageDealt'] = this.totalDamageDealt;
    data['totalDamageDealtToChampions'] = this.totalDamageDealtToChampions;
    data['totalDamageShieldedOnTeammates'] =
        this.totalDamageShieldedOnTeammates;
    data['totalDamageTaken'] = this.totalDamageTaken;
    data['totalHeal'] = this.totalHeal;
    data['totalHealsOnTeammates'] = this.totalHealsOnTeammates;
    data['totalMinionsKilled'] = this.totalMinionsKilled;
    data['totalTimeCCDealt'] = this.totalTimeCCDealt;
    data['totalTimeSpentDead'] = this.totalTimeSpentDead;
    data['totalUnitsHealed'] = this.totalUnitsHealed;
    data['tripleKills'] = this.tripleKills;
    data['trueDamageDealt'] = this.trueDamageDealt;
    data['trueDamageDealtToChampions'] = this.trueDamageDealtToChampions;
    data['trueDamageTaken'] = this.trueDamageTaken;
    data['turretKills'] = this.turretKills;
    data['turretTakedowns'] = this.turretTakedowns;
    data['turretsLost'] = this.turretsLost;
    data['unrealKills'] = this.unrealKills;
    data['visionScore'] = this.visionScore;
    data['visionWardsBoughtInGame'] = this.visionWardsBoughtInGame;
    data['wardsKilled'] = this.wardsKilled;
    data['wardsPlaced'] = this.wardsPlaced;
    data['win'] = this.win;
    return data;
  }
}

class Perks {
  StatPerks? statPerks;
  List<Styles>? styles;

  Perks({this.statPerks, this.styles});

  Perks.fromJson(Map<String, dynamic> json) {
    statPerks = json['statPerks'] != null
        ? new StatPerks.fromJson(json['statPerks'])
        : null;
    if (json['styles'] != null) {
      styles = <Styles>[];
      json['styles'].forEach((v) {
        styles?.add(new Styles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statPerks != null) {
      data['statPerks'] = this.statPerks?.toJson();
    }
    if (this.styles != null) {
      data['styles'] = this.styles?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatPerks {
  int? defense;
  int? flex;
  int? offense;

  StatPerks({this.defense, this.flex, this.offense});

  StatPerks.fromJson(Map<String, dynamic> json) {
    defense = json['defense'];
    flex = json['flex'];
    offense = json['offense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['defense'] = this.defense;
    data['flex'] = this.flex;
    data['offense'] = this.offense;
    return data;
  }
}

class Styles {
  String? description;
  List<Selections>? selections;
  int? style;

  Styles({this.description, this.selections, this.style});

  Styles.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    if (json['selections'] != null) {
      selections = <Selections>[];
      json['selections'].forEach((v) {
        selections?.add(new Selections.fromJson(v));
      });
    }
    style = json['style'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    if (this.selections != null) {
      data['selections'] = this.selections?.map((v) => v.toJson()).toList();
    }
    data['style'] = this.style;
    return data;
  }
}

class Selections {
  int? perk;
  int? var1;
  int? var2;
  int? var3;

  Selections({this.perk, this.var1, this.var2, this.var3});

  Selections.fromJson(Map<String, dynamic> json) {
    perk = json['perk'];
    var1 = json['var1'];
    var2 = json['var2'];
    var3 = json['var3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['perk'] = this.perk;
    data['var1'] = this.var1;
    data['var2'] = this.var2;
    data['var3'] = this.var3;
    return data;
  }
}

class Teams {
  List<Bans>? bans;
  Objectives? objectives;
  int? teamId;
  bool? win;

  Teams({this.bans, this.objectives, this.teamId, this.win});

  Teams.fromJson(Map<String, dynamic> json) {
    if (json['bans'] != null) {
      bans = <Bans>[];
      json['bans'].forEach((v) {
        bans?.add(new Bans.fromJson(v));
      });
    }
    objectives = json['objectives'] != null
        ? new Objectives.fromJson(json['objectives'])
        : null;
    teamId = json['teamId'];
    win = json['win'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bans != null) {
      data['bans'] = this.bans?.map((v) => v.toJson()).toList();
    }
    if (this.objectives != null) {
      data['objectives'] = this.objectives?.toJson();
    }
    data['teamId'] = this.teamId;
    data['win'] = this.win;
    return data;
  }
}

class Bans {
  int? championId;
  int? pickTurn;

  Bans({this.championId, this.pickTurn});

  Bans.fromJson(Map<String, dynamic> json) {
    championId = json['championId'];
    pickTurn = json['pickTurn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['championId'] = this.championId;
    data['pickTurn'] = this.pickTurn;
    return data;
  }
}

class Objectives {
  Baron? baron;
  Baron? champion;
  Baron? dragon;
  Baron? inhibitor;
  Baron? riftHerald;
  Baron? tower;

  Objectives(
      {this.baron,
        this.champion,
        this.dragon,
        this.inhibitor,
        this.riftHerald,
        this.tower});

  Objectives.fromJson(Map<String, dynamic> json) {
    baron = json['baron'] != null ? new Baron.fromJson(json['baron']) : null;
    champion =
    json['champion'] != null ? new Baron.fromJson(json['champion']) : null;
    dragon = json['dragon'] != null ? new Baron.fromJson(json['dragon']) : null;
    inhibitor = json['inhibitor'] != null
        ? new Baron.fromJson(json['inhibitor'])
        : null;
    riftHerald = json['riftHerald'] != null
        ? new Baron.fromJson(json['riftHerald'])
        : null;
    tower = json['tower'] != null ? new Baron.fromJson(json['tower']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.baron != null) {
      data['baron'] = this.baron?.toJson();
    }
    if (this.champion != null) {
      data['champion'] = this.champion?.toJson();
    }
    if (this.dragon != null) {
      data['dragon'] = this.dragon?.toJson();
    }
    if (this.inhibitor != null) {
      data['inhibitor'] = this.inhibitor?.toJson();
    }
    if (this.riftHerald != null) {
      data['riftHerald'] = this.riftHerald?.toJson();
    }
    if (this.tower != null) {
      data['tower'] = this.tower?.toJson();
    }
    return data;
  }
}

class Baron {
  bool? first;
  int? kills;

  Baron({this.first, this.kills});

  Baron.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    kills = json['kills'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['kills'] = this.kills;
    return data;
  }
}
