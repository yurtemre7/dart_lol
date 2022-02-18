import 'dart:convert';

import 'package:localstorage/localstorage.dart';

import 'LeagueStuff/champions.dart';
import 'ddragon_api.dart';

class DDragonStorage {
  final dDragonLocalStorage = new LocalStorage('ddragon_storage');
  final versionsKey = "ddragon_versions";
  final versionsLastSaved = "versions_last_saved";
  var currentVersion = "";

  /// VERSIONS
  Future saveVersions(List<String> versions) async {
    await dDragonLocalStorage.setItem(versionsKey, versions);
    await dDragonLocalStorage.setItem(versionsLastSaved, DateTime.now().millisecondsSinceEpoch);
  }

  Future<int> getVersionsLastUpdated() async {
    return await dDragonLocalStorage.getItem(versionsLastSaved);
  }

  Future<String> getVersionFromDb() async {
    if(currentVersion != "") {
      return currentVersion;
    }
    final version = await dDragonLocalStorage.getItem(versionsKey);
    if(version == null) {
      final versionAPI = await DDragonAPI().getVersionsFromApi();
      currentVersion = versionAPI[0];
      return currentVersion;
    }
    currentVersion = version[0];
    return currentVersion;
  }

  /// Champions
  final championsKey = "champions_key";
  final championsLastSaved = "champions_last_saved";
  saveChampions(String champions) {
    dDragonLocalStorage.setItem(championsKey, champions);
    dDragonLocalStorage.setItem(championsLastSaved, DateTime.now().millisecondsSinceEpoch);
  }

  int getChampionsLastUpdated() {
    return dDragonLocalStorage.getItem(championsLastSaved);
  }

  Future<Champions> getChampionsFromDb() async {
    final championsString = await dDragonLocalStorage.getItem(championsKey);
    if(championsString == null)
      return await DDragonAPI().getChampionsFromApi();
    return Champions.fromJson(json.decode(championsString));
  }
}
