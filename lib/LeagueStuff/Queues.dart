// To parse this JSON data, do
//
//     final queues = queuesFromJson(jsonString);

import 'dart:convert';

List<Queues> queuesFromJson(String str) => List<Queues>.from(json.decode(str).map((x) => Queues.fromJson(x)));

String queuesToJson(List<Queues> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Queues {
  Queues({
    this.queueId,
    this.map,
    this.description,
    this.notes,
  });

  final int? queueId;
  final String? map;
  final String? description;
  final String? notes;

  factory Queues.fromJson(Map<String, dynamic> json) => Queues(
    queueId: json["queueId"] == null ? null : json["queueId"],
    map: json["map"] == null ? null : json["map"],
    description: json["description"] == null ? null : json["description"],
    notes: json["notes"] == null ? null : json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "queueId": queueId == null ? null : queueId,
    "map": map == null ? null : map,
    "description": description == null ? null : description,
    "notes": notes == null ? null : notes,
  };
}
