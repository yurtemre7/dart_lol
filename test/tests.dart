import 'package:dart_lol/dart_lol.dart';
import 'package:dart_lol/key.dart';

var summID = 'Gg7L1t2E8chqirSQGhg_M1PAtl52v-KAONcZUFeoBJAIhx1j';
var summName = 'Rengar Says MIAW';
var emre = 'Ÿurt';

void main() {
  final league = League(apiToken: key);

  league.getSummonerInfo(summonerName: 'Ÿurt').then((summonerInfo) async {
    print(summonerInfo.summonerName);
    // Outputs Ÿurt
    print(summonerInfo.level);
    // Outputs current summoner level
    // etc.
    var games = await league.getGameHistory(
        accountID: summonerInfo.accID, summonerName: 'Ÿurt');
    games[0].stats().then((stats) {
      print(stats.participants[stats.playerIDinGame - 1].items);
    });
    games[2].stats().then((stats) {
      print(stats.participants[stats.playerIDinGame - 1].items);
    });
  });

  //final summonerInfo = league.getSummonerInfo(summonerName: summName);
}
