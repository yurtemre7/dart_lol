class Match {
  Metadata? metadata;
  Info? info;

  Match({this.metadata, this.info});

  Match.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    if (info != null) {
      data['info'] = info!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dataVersion'] = dataVersion;
    data['matchId'] = matchId;
    data['participants'] = participants;
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
        participants!.add(Participants.fromJson(v));
      });
    }
    platformId = json['platformId'];
    queueId = json['queueId'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(Teams.fromJson(v));
      });
    }
    tournamentCode = json['tournamentCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gameCreation'] = gameCreation;
    data['gameDuration'] = gameDuration;
    data['gameId'] = gameId;
    data['gameMode'] = gameMode;
    data['gameName'] = gameName;
    data['gameStartTimestamp'] = gameStartTimestamp;
    data['gameType'] = gameType;
    data['gameVersion'] = gameVersion;
    data['mapId'] = mapId;
    if (participants != null) {
      data['participants'] = participants!.map((v) => v.toJson()).toList();
    }
    data['platformId'] = platformId;
    data['queueId'] = queueId;
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    data['tournamentCode'] = tournamentCode;
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
    perks = json['perks'] != null ? Perks.fromJson(json['perks']) : null;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assists'] = assists;
    data['baronKills'] = baronKills;
    data['bountyLevel'] = bountyLevel;
    data['champExperience'] = champExperience;
    data['champLevel'] = champLevel;
    data['championId'] = championId;
    data['championName'] = championName;
    data['championTransform'] = championTransform;
    data['consumablesPurchased'] = consumablesPurchased;
    data['damageDealtToBuildings'] = damageDealtToBuildings;
    data['damageDealtToObjectives'] = damageDealtToObjectives;
    data['damageDealtToTurrets'] = damageDealtToTurrets;
    data['damageSelfMitigated'] = damageSelfMitigated;
    data['deaths'] = deaths;
    data['detectorWardsPlaced'] = detectorWardsPlaced;
    data['doubleKills'] = doubleKills;
    data['dragonKills'] = dragonKills;
    data['firstBloodAssist'] = firstBloodAssist;
    data['firstBloodKill'] = firstBloodKill;
    data['firstTowerAssist'] = firstTowerAssist;
    data['firstTowerKill'] = firstTowerKill;
    data['gameEndedInEarlySurrender'] = gameEndedInEarlySurrender;
    data['gameEndedInSurrender'] = gameEndedInSurrender;
    data['goldEarned'] = goldEarned;
    data['goldSpent'] = goldSpent;
    data['individualPosition'] = individualPosition;
    data['inhibitorKills'] = inhibitorKills;
    data['inhibitorTakedowns'] = inhibitorTakedowns;
    data['inhibitorsLost'] = inhibitorsLost;
    data['item0'] = item0;
    data['item1'] = item1;
    data['item2'] = item2;
    data['item3'] = item3;
    data['item4'] = item4;
    data['item5'] = item5;
    data['item6'] = item6;
    data['itemsPurchased'] = itemsPurchased;
    data['killingSprees'] = killingSprees;
    data['kills'] = kills;
    data['lane'] = lane;
    data['largestCriticalStrike'] = largestCriticalStrike;
    data['largestKillingSpree'] = largestKillingSpree;
    data['largestMultiKill'] = largestMultiKill;
    data['longestTimeSpentLiving'] = longestTimeSpentLiving;
    data['magicDamageDealt'] = magicDamageDealt;
    data['magicDamageDealtToChampions'] = magicDamageDealtToChampions;
    data['magicDamageTaken'] = magicDamageTaken;
    data['neutralMinionsKilled'] = neutralMinionsKilled;
    data['nexusKills'] = nexusKills;
    data['nexusLost'] = nexusLost;
    data['nexusTakedowns'] = nexusTakedowns;
    data['objectivesStolen'] = objectivesStolen;
    data['objectivesStolenAssists'] = objectivesStolenAssists;
    data['participantId'] = participantId;
    data['pentaKills'] = pentaKills;
    if (perks != null) {
      data['perks'] = perks?.toJson();
    }
    data['physicalDamageDealt'] = physicalDamageDealt;
    data['physicalDamageDealtToChampions'] = physicalDamageDealtToChampions;
    data['physicalDamageTaken'] = physicalDamageTaken;
    data['profileIcon'] = profileIcon;
    data['puuid'] = puuid;
    data['quadraKills'] = quadraKills;
    data['riotIdName'] = riotIdName;
    data['riotIdTagline'] = riotIdTagline;
    data['role'] = role;
    data['sightWardsBoughtInGame'] = sightWardsBoughtInGame;
    data['spell1Casts'] = spell1Casts;
    data['spell2Casts'] = spell2Casts;
    data['spell3Casts'] = spell3Casts;
    data['spell4Casts'] = spell4Casts;
    data['summoner1Casts'] = summoner1Casts;
    data['summoner1Id'] = summoner1Id;
    data['summoner2Casts'] = summoner2Casts;
    data['summoner2Id'] = summoner2Id;
    data['summonerId'] = summonerId;
    data['summonerLevel'] = summonerLevel;
    data['summonerName'] = summonerName;
    data['teamEarlySurrendered'] = teamEarlySurrendered;
    data['teamId'] = teamId;
    data['teamPosition'] = teamPosition;
    data['timeCCingOthers'] = timeCCingOthers;
    data['timePlayed'] = timePlayed;
    data['totalDamageDealt'] = totalDamageDealt;
    data['totalDamageDealtToChampions'] = totalDamageDealtToChampions;
    data['totalDamageShieldedOnTeammates'] = totalDamageShieldedOnTeammates;
    data['totalDamageTaken'] = totalDamageTaken;
    data['totalHeal'] = totalHeal;
    data['totalHealsOnTeammates'] = totalHealsOnTeammates;
    data['totalMinionsKilled'] = totalMinionsKilled;
    data['totalTimeCCDealt'] = totalTimeCCDealt;
    data['totalTimeSpentDead'] = totalTimeSpentDead;
    data['totalUnitsHealed'] = totalUnitsHealed;
    data['tripleKills'] = tripleKills;
    data['trueDamageDealt'] = trueDamageDealt;
    data['trueDamageDealtToChampions'] = trueDamageDealtToChampions;
    data['trueDamageTaken'] = trueDamageTaken;
    data['turretKills'] = turretKills;
    data['turretTakedowns'] = turretTakedowns;
    data['turretsLost'] = turretsLost;
    data['unrealKills'] = unrealKills;
    data['visionScore'] = visionScore;
    data['visionWardsBoughtInGame'] = visionWardsBoughtInGame;
    data['wardsKilled'] = wardsKilled;
    data['wardsPlaced'] = wardsPlaced;
    data['win'] = win;
    return data;
  }
}

class Perks {
  StatPerks? statPerks;
  List<Styles>? styles;

  Perks({this.statPerks, this.styles});

  Perks.fromJson(Map<String, dynamic> json) {
    statPerks = json['statPerks'] != null ? StatPerks.fromJson(json['statPerks']) : null;
    if (json['styles'] != null) {
      styles = <Styles>[];
      json['styles'].forEach((v) {
        styles?.add(Styles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (statPerks != null) {
      data['statPerks'] = statPerks?.toJson();
    }
    if (styles != null) {
      data['styles'] = styles?.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['defense'] = defense;
    data['flex'] = flex;
    data['offense'] = offense;
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
        selections?.add(Selections.fromJson(v));
      });
    }
    style = json['style'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    if (selections != null) {
      data['selections'] = selections?.map((v) => v.toJson()).toList();
    }
    data['style'] = style;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['perk'] = perk;
    data['var1'] = var1;
    data['var2'] = var2;
    data['var3'] = var3;
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
        bans?.add(Bans.fromJson(v));
      });
    }
    objectives = json['objectives'] != null ? Objectives.fromJson(json['objectives']) : null;
    teamId = json['teamId'];
    win = json['win'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bans != null) {
      data['bans'] = bans?.map((v) => v.toJson()).toList();
    }
    if (objectives != null) {
      data['objectives'] = objectives?.toJson();
    }
    data['teamId'] = teamId;
    data['win'] = win;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['championId'] = championId;
    data['pickTurn'] = pickTurn;
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

  Objectives({this.baron, this.champion, this.dragon, this.inhibitor, this.riftHerald, this.tower});

  Objectives.fromJson(Map<String, dynamic> json) {
    baron = json['baron'] != null ? Baron.fromJson(json['baron']) : null;
    champion = json['champion'] != null ? Baron.fromJson(json['champion']) : null;
    dragon = json['dragon'] != null ? Baron.fromJson(json['dragon']) : null;
    inhibitor = json['inhibitor'] != null ? Baron.fromJson(json['inhibitor']) : null;
    riftHerald = json['riftHerald'] != null ? Baron.fromJson(json['riftHerald']) : null;
    tower = json['tower'] != null ? Baron.fromJson(json['tower']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (baron != null) {
      data['baron'] = baron?.toJson();
    }
    if (champion != null) {
      data['champion'] = champion?.toJson();
    }
    if (dragon != null) {
      data['dragon'] = dragon?.toJson();
    }
    if (inhibitor != null) {
      data['inhibitor'] = inhibitor?.toJson();
    }
    if (riftHerald != null) {
      data['riftHerald'] = riftHerald?.toJson();
    }
    if (tower != null) {
      data['tower'] = tower?.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['kills'] = kills;
    return data;
  }
}
