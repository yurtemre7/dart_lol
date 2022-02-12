import 'champ_names.dart';

class ChampionMastery {
  final int? championID;
  final int? championLevel;
  final int? championPoints;
  final bool? chestGranted;
  final String? championName;

  /// A ChampionMastery() instance to use to create a
  /// custom ChampionMastery or use it with the League()
  /// instance to get real-time Mastery information.
  ChampionMastery({
    this.championID,
    this.championLevel,
    this.championPoints,
    this.chestGranted,
    this.championName,
  });

  factory ChampionMastery.fromJson(Map<String, dynamic> json) {
    return ChampionMastery(
      championID: json['championId'],
      championLevel: json['championLevel'],
      championPoints: json['championPoints'],
      chestGranted: json['chestGranted'],
      championName: getChampNameByID(
        json['championId'],
      ),
    );
  }
}
