// To parse this JSON data, do
//
//     final runesReforged = runesReforgedFromJson(jsonString);

import 'dart:convert';

List<RunesReforged> runesReforgedFromJson(String str) => List<RunesReforged>.from(json.decode(str).map((x) => RunesReforged.fromJson(x)));

String runesReforgedToJson(List<RunesReforged> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RunesReforged {
  RunesReforged({
    this.id,
    this.key,
    this.icon,
    this.name,
    this.slots,
  });

  final int? id;
  final String? key;
  final String? icon;
  final String? name;
  final List<Slot>? slots;

  factory RunesReforged.fromJson(Map<String, dynamic> json) => RunesReforged(
    id: json["id"] == null ? null : json["id"],
    key: json["key"] == null ? null : json["key"],
    icon: json["icon"] == null ? null : json["icon"],
    name: json["name"] == null ? null : json["name"],
    slots: json["slots"] == null ? null : List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "key": key == null ? null : key,
    "icon": icon == null ? null : icon,
    "name": name == null ? null : name,
    "slots": slots == null ? null : List<dynamic>.from(slots!.map((x) => x.toJson())),
  };
}

class Slot {
  Slot({
    this.runes,
  });

  final List<Rune>? runes;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    runes: json["runes"] == null ? null : List<Rune>.from(json["runes"].map((x) => Rune.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "runes": runes == null ? null : List<dynamic>.from(runes!.map((x) => x.toJson())),
  };
}

class Rune {
  Rune({
    this.id,
    this.key,
    this.icon,
    this.name,
    this.shortDesc,
    this.longDesc,
  });

  final int? id;
  final String? key;
  final String? icon;
  final String? name;
  final String? shortDesc;
  final String? longDesc;

  factory Rune.fromJson(Map<String, dynamic> json) => Rune(
    id: json["id"] == null ? null : json["id"],
    key: json["key"] == null ? null : json["key"],
    icon: json["icon"] == null ? null : json["icon"],
    name: json["name"] == null ? null : json["name"],
    shortDesc: json["shortDesc"] == null ? null : json["shortDesc"],
    longDesc: json["longDesc"] == null ? null : json["longDesc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "key": key == null ? null : key,
    "icon": icon == null ? null : icon,
    "name": name == null ? null : name,
    "shortDesc": shortDesc == null ? null : shortDesc,
    "longDesc": longDesc == null ? null : longDesc,
  };
}
