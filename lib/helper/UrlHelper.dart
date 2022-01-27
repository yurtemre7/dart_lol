import 'package:dart_lol/ddragon_api.dart';
import 'package:dart_lol/ddragon_storage.dart';
import 'package:get_it/get_it.dart';

class UrlHelper {
  final DDRAGON_BASE = "https://ddragon.leagueoflegends.com/";

  //var dDragonStorage = DDragonStorage();

  Future<String> getRiotGamesAPIVersion() async {
    var dDragonStorage = GetIt.instance<DDragonStorage>();
    final versionList = dDragonStorage.getVersionFromDb();
    return versionList;
    //return "12.2.1";
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
}
