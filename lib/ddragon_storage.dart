import 'package:localstorage/localstorage.dart';

class DDragonStorage {
  final dDragonStorage = new LocalStorage('ddragon_storage');

  final versionsKey = "ddragon_versions";
  final versionsLastSaved = "versions_last_saved";

  saveVersions(List<String> versions) {
    dDragonStorage.setItem(versionsKey, versions);
    dDragonStorage.setItem(versionsLastSaved, DateTime.now().millisecondsSinceEpoch);
  }

  int getVersionsLastUpdated() {
    return dDragonStorage.getItem(versionsLastSaved);
  }

  List<String> getVersions() {
    return dDragonStorage.getItem(versionsKey);
  }
}
