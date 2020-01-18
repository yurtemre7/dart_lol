import 'package:dart_lol/dart_lol.dart';
import 'package:dart_lol/key.dart';

var summID = 'Gg7L1t2E8chqirSQGhg_M1PAtl52v-KAONcZUFeoBJAIhx1j';
var summName = 'Rengar Says MIAW';
var emre = 'Ÿurt';

void main() {
  final league = League(apiToken: key);

  league.getSummonerInfo(summonerName: 'Ÿurt').then(
    (summonerInfo) {
    print(summonerInfo.summonerName);
    // Outputs Ÿurt
    print(summonerInfo.level);
    // Outputs current summoner level
    // etc.
    league.getGameHistory(accountID: summonerInfo.accID).then((games){
      games[5].stats().then((stats){
        print(stats.win);
      });
    });
  });

  //final summonerInfo = league.getSummonerInfo(summonerName: summName);
}
