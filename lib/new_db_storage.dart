import 'package:localstorage/localstorage.dart';

class NewDbStorage {
  final LocalStorage summonerStorage = LocalStorage('summoners');
  final LocalStorage matchHistoryStorage = LocalStorage('histories');
  final LocalStorage matchStorage = LocalStorage('myMatches');
  final LocalStorage rankedChallengerSoloStorage = LocalStorage('rankedSummoners');

  NewDbStorage() {
    print("init");
  }

  Future saveThat() async {
    print("starting saving");
    await summonerStorage.setItem("the_key", "69");
    await matchHistoryStorage.setItem("the_key", "69");
    print("finished saving");
  }
}