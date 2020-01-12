import 'package:dart_lol/dart_lol.dart';

var summID = 'Gg7L1t2E8chqirSQGhg_M1PAtl52v-KAONcZUFeoBJAIhx1j';
var summName = 'Rengar Says MIAW';
var emre = 'Ÿurt';

void main() {
  final league = League(apiToken: apiToken);

  league.getSummonerInfo(summonerName: 'Ÿurt').then((summonerInfo) {
    print(summonerInfo.summonerName);
    // Outputs Ÿurt
    print(summonerInfo.level);
    // Outputs current summoner level
    // etc.
  });

  league.getSummonerInfo(summonerName: emre).then((id) {
    final game = league.getGameHistory(accountID: id.accID);
    game.then((gameStat) {

      print(gameStat[1].championName);
      // Always outputs your stats for any game in the List of GameStat

      gameStat[2].stats().then((ok) {

        print(ok.participants[1].summonerName);
        // Outputs the second summoners name
        league
            .getRankInfos(summonerID: ok.participants[6].summonerID)
            .then((rankInfo) {

          print(rankInfo.leaguePoints);
          print(rankInfo.tier);
          // Outputs the sixth summoners current league points and his current tier
        });
      });
    });
  });

  //final summonerInfo = league.getSummonerInfo(summonerName: summName);
}
