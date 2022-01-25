import 'dart:convert';

import 'package:localstorage/localstorage.dart';

import 'LeagueStuff/champions.dart';
import 'ddragon_api.dart';

class DDragonStorage {
  final dDragonStorage = new LocalStorage('ddragon_storage');
  final versionsKey = "ddragon_versions";
  final versionsLastSaved = "versions_last_saved";

  //final dDragonApi = DDragonAPI();

  var currentVersion = "";

  /// VERSIONS
  saveVersions(List<String> versions) {
    dDragonStorage.setItem(versionsKey, versions);
    dDragonStorage.setItem(versionsLastSaved, DateTime.now().millisecondsSinceEpoch);
  }

  int getVersionsLastUpdated() {
    return dDragonStorage.getItem(versionsLastSaved);
  }

  Future<String> getVersionFromDb() async {
    if(currentVersion != "") {
      print("We're returning the version");
      return currentVersion;
    }
    print("We're getting the version from db/api");
    final version = dDragonStorage.getItem(versionsKey);
    if(version == null) {
      final versionAPI = await DDragonAPI().getVersionsFromApi();
      currentVersion = versionAPI[0];
      print("Set version to $currentVersion");
      return currentVersion;
    }
    currentVersion = version[0];
    print("Set version to $currentVersion");
    return currentVersion;
  }

  /// Champions
  final championsKey = "champions_key";
  final championsLastSaved = "champions_last_saved";
  saveChampions(String champions) {
    dDragonStorage.setItem(championsKey, champions);
    dDragonStorage.setItem(championsLastSaved, DateTime.now().millisecondsSinceEpoch);
  }

  int getChampionsLastUpdated() {
    return dDragonStorage.getItem(championsLastSaved);
  }

  Future<Champions> getChampionsFromDb() async {
    print("getChampionsFromDb");
    final championsString = dDragonStorage.getItem(championsKey);
    if(championsString == null)
      return await DDragonAPI().getChampionsFromApi();
    return Champions.fromJson(json.decode(championsString));
  }
}
