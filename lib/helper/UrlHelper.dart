
import 'package:dart_lol/ddragon_api.dart';

class UrlHelper {
  final DDRAGON_BASE = "https://ddragon.leagueoflegends.com/";

  Future<String> getRiotGamesAPIVersion() async {
    final versionList = await DDragonAPI().getVersionsFromApi();
    return versionList[0];
  }

  String buildChampionImage(String imageEnding) {
    return "";
  }

  //https://ddragon.leagueoflegends.com/api/versions.json
  String returnVersionsUrl() {
    return "${DDRAGON_BASE}api/versions.json";
  }

  // String buildChampions() {
  //
  // }



}