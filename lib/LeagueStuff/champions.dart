// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Champions welcomeFromJson(String str) => Champions.fromJson(json.decode(str));

String welcomeToJson(Champions data) => json.encode(data.toJson());

class Champions {
  Champions({
    this.type,
    this.format,
    this.version,
    this.data,
  });

  final Type? type;
  final String? format;
  final Version? version;
  final Map<String, Datum>? data;

  factory Champions.fromJson(Map<String, dynamic> json) => Champions(
    type: json["type"] == null ? null : typeValues.map[json["type"]],
    format: json["format"] == null ? null : json["format"],
    version: json["version"] == null ? null : versionValues.map[json["version"]],
    data: json["data"] == null ? null : Map.from(json["data"]).map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : typeValues.reverse?[type],
    "format": format == null ? null : format,
    "version": version == null ? null : versionValues.reverse?[version],
    "data": data == null ? null : Map.from(data!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Datum {
  Datum({
    this.version,
    this.id,
    this.key,
    this.name,
    this.title,
    this.blurb,
    this.info,
    this.image,
    this.tags,
    this.partype,
    this.stats,
  });

  final Version? version;
  final String? id;
  final String? key;
  final String? name;
  final String? title;
  final String? blurb;
  final Info? info;
  final Image? image;
  final List<Tag>? tags;
  final String? partype;
  final Map<String, double>? stats;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    version: json["version"] == null ? null : versionValues.map[json["version"]],
    id: json["id"] == null ? null : json["id"],
    key: json["key"] == null ? null : json["key"],
    name: json["name"] == null ? null : json["name"],
    title: json["title"] == null ? null : json["title"],
    blurb: json["blurb"] == null ? null : json["blurb"],
    info: json["info"] == null ? null : Info.fromJson(json["info"]),
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    tags: json["tags"] == null ? null : List<Tag>.from(json["tags"].map((x) => tagValues.map[x])),
    partype: json["partype"] == null ? null : json["partype"],
    stats: json["stats"] == null ? null : Map.from(json["stats"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "version": version == null ? null : versionValues.reverse?[version],
    "id": id == null ? null : id,
    "key": key == null ? null : key,
    "name": name == null ? null : name,
    "title": title == null ? null : title,
    "blurb": blurb == null ? null : blurb,
    "info": info == null ? null : info?.toJson(),
    "image": image == null ? null : image?.toJson(),
    "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => tagValues.reverse?[x])),
    "partype": partype == null ? null : partype,
    "stats": stats == null ? null : Map.from(stats!).map((k, v) => MapEntry<String, dynamic>(k, v)),
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
  final Type? group;
  final int? x;
  final int? y;
  final int? w;
  final int? h;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    full: json["full"] == null ? null : json["full"],
    sprite: json["sprite"] == null ? null : spriteValues.map[json["sprite"]],
    group: json["group"] == null ? null : typeValues.map[json["group"]],
    x: json["x"] == null ? null : json["x"],
    y: json["y"] == null ? null : json["y"],
    w: json["w"] == null ? null : json["w"],
    h: json["h"] == null ? null : json["h"],
  );

  Map<String, dynamic> toJson() => {
    "full": full == null ? null : full,
    "sprite": sprite == null ? null : spriteValues.reverse?[sprite],
    "group": group == null ? null : typeValues.reverse?[group],
    "x": x == null ? null : x,
    "y": y == null ? null : y,
    "w": w == null ? null : w,
    "h": h == null ? null : h,
  };
}

enum Type { CHAMPION }

final typeValues = EnumValues({
  "champion": Type.CHAMPION
});

enum Sprite { CHAMPION0_PNG, CHAMPION1_PNG, CHAMPION2_PNG, CHAMPION3_PNG, CHAMPION4_PNG, CHAMPION5_PNG }

final spriteValues = EnumValues({
  "champion0.png": Sprite.CHAMPION0_PNG,
  "champion1.png": Sprite.CHAMPION1_PNG,
  "champion2.png": Sprite.CHAMPION2_PNG,
  "champion3.png": Sprite.CHAMPION3_PNG,
  "champion4.png": Sprite.CHAMPION4_PNG,
  "champion5.png": Sprite.CHAMPION5_PNG
});

class Info {
  Info({
    this.attack,
    this.defense,
    this.magic,
    this.difficulty,
  });

  final int? attack;
  final int? defense;
  final int? magic;
  final int? difficulty;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    attack: json["attack"] == null ? null : json["attack"],
    defense: json["defense"] == null ? null : json["defense"],
    magic: json["magic"] == null ? null : json["magic"],
    difficulty: json["difficulty"] == null ? null : json["difficulty"],
  );

  Map<String, dynamic> toJson() => {
    "attack": attack == null ? null : attack,
    "defense": defense == null ? null : defense,
    "magic": magic == null ? null : magic,
    "difficulty": difficulty == null ? null : difficulty,
  };
}

enum Tag { FIGHTER, TANK, MAGE, ASSASSIN, MARKSMAN, SUPPORT }

final tagValues = EnumValues({
  "Assassin": Tag.ASSASSIN,
  "Fighter": Tag.FIGHTER,
  "Mage": Tag.MAGE,
  "Marksman": Tag.MARKSMAN,
  "Support": Tag.SUPPORT,
  "Tank": Tag.TANK
});

enum Version { THE_1221 }

final versionValues = EnumValues({
  "12.2.1": Version.THE_1221
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
