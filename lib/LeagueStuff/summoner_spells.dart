// To parse this JSON data, do
//
//     final summonerSpell = summonerSpellFromJson(jsonString);

import 'dart:convert';

SummonerSpell summonerSpellFromJson(String str) => SummonerSpell.fromJson(json.decode(str));

String summonerSpellToJson(SummonerSpell data) => json.encode(data.toJson());

class SummonerSpell {
  SummonerSpell({
    this.type,
    this.version,
    this.data,
  });

  final String? type;
  final String? version;
  final Map<String, dynamic>? data;

  factory SummonerSpell.fromJson(Map<String, dynamic> json) => SummonerSpell(
    type: json["type"],
    version: json["version"],
    data: Map.from(json["data"]).map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "version": version,
    "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.description,
    this.tooltip,
    this.maxrank,
    this.cooldown,
    this.cooldownBurn,
    this.cost,
    this.costBurn,
    this.datavalues,
    this.effect,
    this.effectBurn,
    this.vars,
    this.key,
    this.summonerLevel,
    this.modes,
    this.costType,
    this.maxammo,
    this.range,
    this.rangeBurn,
    this.image,
    this.resource,
  });

  final String? id;
  final String? name;
  final String? description;
  final String? tooltip;
  final int? maxrank;
  final List<int>? cooldown;
  final String? cooldownBurn;
  final List<int>? cost;
  final String? costBurn;
  final Datavalues? datavalues;
  final List<List<double>>? effect;
  final List<String>? effectBurn;
  final List<dynamic>? vars;
  final String? key;
  final int? summonerLevel;
  final List<String>? modes;
  final CostType? costType;
  final String? maxammo;
  final List<int>? range;
  final String? rangeBurn;
  final Image? image;
  final CostType? resource;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    tooltip: json["tooltip"],
    maxrank: json["maxrank"],
    cooldown: List<int>.from(json["cooldown"].map((x) => x)),
    cooldownBurn: json["cooldownBurn"],
    cost: List<int>.from(json["cost"].map((x) => x)),
    costBurn: json["costBurn"],
    datavalues: Datavalues.fromJson(json["datavalues"]),
    effect: List<List<double>>.from(json["effect"].map((x) => x == null ? null : List<double>.from(x.map((x) => x.toDouble())))),
    effectBurn: List<String>.from(json["effectBurn"].map((x) => x == null ? null : x)),
    vars: List<dynamic>.from(json["vars"].map((x) => x)),
    key: json["key"],
    summonerLevel: json["summonerLevel"],
    modes: List<String>.from(json["modes"].map((x) => x)),
    costType: costTypeValues.map?[json["costType"]],
    maxammo: json["maxammo"],
    range: List<int>.from(json["range"].map((x) => x)),
    rangeBurn: json["rangeBurn"],
    image: Image.fromJson(json["image"]),
    resource: costTypeValues.map?[json["resource"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "tooltip": tooltip,
    "maxrank": maxrank,
    "cooldown": List<dynamic>.from(cooldown!.map((x) => x)),
    "cooldownBurn": cooldownBurn,
    "cost": List<dynamic>.from(cost!.map((x) => x)),
    "costBurn": costBurn,
    "datavalues": datavalues?.toJson(),
    "effect": List<dynamic>.from(effect!.map((x) => x == null ? null : List<dynamic>.from(x.map((x) => x)))),
    "effectBurn": List<dynamic>.from(effectBurn!.map((x) => x == null ? null : x)),
    "vars": List<dynamic>.from(vars!.map((x) => x)),
    "key": key,
    "summonerLevel": summonerLevel,
    "modes": List<dynamic>.from(modes!.map((x) => x)),
    "costType": costTypeValues.reverse?[costType],
    "maxammo": maxammo,
    "range": List<dynamic>.from(range!.map((x) => x)),
    "rangeBurn": rangeBurn,
    "image": image?.toJson(),
    "resource": costTypeValues.reverse![resource],
  };
}

enum CostType { NO_COST, NBSP }

final costTypeValues = SpellEnumValues({
  "&nbsp;": CostType.NBSP,
  "No Cost": CostType.NO_COST
});

class Datavalues {
  Datavalues();

  factory Datavalues.fromJson(Map<String, dynamic> json) => Datavalues(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Image {
  Image({
    this.full,
    this.sprite,
    this.group,
    this.x,
    this.y,
    this.w,
    this.h,
  });

  final String? full;
  final Sprite? sprite;
  final Group? group;
  final int? x;
  final int? y;
  final int? w;
  final int? h;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    full: json["full"],
    sprite: spriteValues.map?[json["sprite"]],
    group: groupValues.map?[json["group"]],
    x: json["x"],
    y: json["y"],
    w: json["w"],
    h: json["h"],
  );

  Map<String, dynamic> toJson() => {
    "full": full,
    "sprite": spriteValues.reverse?[sprite],
    "group": groupValues.reverse?[group],
    "x": x,
    "y": y,
    "w": w,
    "h": h,
  };
}

enum Group { SPELL }

final groupValues = SpellEnumValues({
  "spell": Group.SPELL
});

enum Sprite { SPELL0_PNG }

final spriteValues = SpellEnumValues({
  "spell0.png": Sprite.SPELL0_PNG
});

class SpellEnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  SpellEnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
