import 'dart:convert';

import 'package:localstorage/localstorage.dart';

import 'LeagueStuff/champions.dart';
import 'ddragon_api.dart';

class DDragonStorage {
  final dDragonStorage = new LocalStorage('ddragon_storage');

  final versionsKey = "ddragon_versions";
  final versionsLastSaved = "versions_last_saved";

  /// VERSIONS
  saveVersions(List<String> versions) {
    dDragonStorage.setItem(versionsKey, versions);
    dDragonStorage.setItem(versionsLastSaved, DateTime.now().millisecondsSinceEpoch);
  }

  int getVersionsLastUpdated() {
    return dDragonStorage.getItem(versionsLastSaved);
  }

  String getRiotGamesAPIVersion() {
    return dDragonStorage.getItem(versionsKey)[0];
  }

  /// Champions
  final championsKey = "champions_key";
  final championsLastSaved = "champions_last_saved";
  saveChampions(String champions) {
    print(champions);
    dDragonStorage.setItem(championsKey, champions);
    dDragonStorage.setItem(championsLastSaved, DateTime.now().millisecondsSinceEpoch);
  }

  int getChampionsLastUpdated() {
    return dDragonStorage.getItem(championsLastSaved);
  }

  Future<Champions> getChampionsFromDb() async {
    final championsString = dDragonStorage.getItem(championsKey);
    if(championsString == null)
      return await DDragonAPI().getChampionsFromApi();
    return Champions.fromJson(json.decode(championsString));
  }
}
