import 'package:dart_lol/ddragon_api.dart';
import 'package:dart_lol/ddragon_storage.dart';
import 'package:get_it/get_it.dart';

import '../ddragon_storage.dart';

class UrlHelper {
  final DDRAGON_BASE = "https://ddragon.leagueoflegends.com/";
  var apiKey = "";

  //return "12.2.1";
  Future<String> getRiotGamesAPIVersion() async {
    var dDragonStorage = GetIt.instance<DDragonStorage>();
    final versionList = dDragonStorage.getVersionFromDb();
    return versionList;
  }

  //https://ddragon.leagueoflegends.com/api/versions.json
  String returnVersionsUrl() {
    return "${DDRAGON_BASE}api/versions.json";
  }

  //http://ddragon.leagueoflegends.com/cdn/9.11.1/data/en_US/champion.json
  Future<String> buildChampions() async {
    final v = await getRiotGamesAPIVersion();
    return "${DDRAGON_BASE}cdn/$v/data/en_US/champion.json";
  }

  Future<String> buildChampionImage(String imageEnding) async {
    final v = await getRiotGamesAPIVersion();
    return "${DDRAGON_BASE}cdn/$v/img/champion/${imageEnding}";
  }

  /// Profile Icon
  Future<String> buildProfileIcon(int iconId) async {
    final v = await getRiotGamesAPIVersion();
    return "${DDRAGON_BASE}/cdn/$v/img/profileicon/$iconId.png";
  }

  Future<String> buildItemImage(String full) async {
    final v = await getRiotGamesAPIVersion();
    return "${DDRAGON_BASE}cdn/$v/img/item/$full";
  }

  //https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Fizz_1.jpg
  String buildSplashArt(String name) {
    return "${DDRAGON_BASE}cdn/img/champion/splash/${name}_1.jpg";
  }

  String buildRuneImage(String url) {
    return "${DDRAGON_BASE}cdn/img/$url";
  }

  /** na1. api **/
  //https://na1.api.riotgames.com/lol/league/v4/challengerleagues/by-queue/RANKED_SOLO_5x5
  String buildChallengerLeagueByQueue(String queue) {
    return "league/v4/challengerleagues/by-queue/RANKED_SOLO_5x5?api_key=$apiKey";
  }

  String buildGrandmasterLeagueByQueue(String queue) {
    return "league/v4/grandmasterleagues/by-queue/RANKED_SOLO_5x5?api_key=$apiKey";
  }

  //https://na1.api.riotgames.com/lol/league/v4/entries/by-summoner/p0AX3fC5pERFzCffvHAUwGU72cLtauy1-jcktSdTCyUpMI4
  String buildLeague(String id) {
    return "league/v4/entries/by-summoner/$id?api_key=$apiKey";
  }
}
