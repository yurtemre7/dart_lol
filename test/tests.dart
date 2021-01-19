import 'package:dart_lol/dart_lol.dart';
import 'package:dart_lol/key.dart';
import 'package:http/http.dart' as http;

var summID = 'Gg7L1t2E8chqirSQGhg_M1PAtl52v-KAONcZUFeoBJAIhx1j';
var summName = 'Rengar Says MIAW';
var emre = 'Cord';

main() async {
  final league = League(apiToken: key);
  var summonerInfo = await league.getSummonerInfo(summonerName: emre);
  /*var url =
      'https://euw1.api.riotgames.com/lol/spectator/v4/active-games/by-summoner/${summonerInfo.summonerID}?api_key=$key';
  var response = await http.get(
    url,
  );

  print(response.body);*/
  var crnt = await league.getCurrentGame(summonerID: summonerInfo.summonerID, summonerName: emre);
  print(crnt.data);

  /*league.getSummonerInfo(summonerName: 'Ÿurt').then((summonerInfo) async {
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
  });*/

  //final summonerInfo = league.getSummonerInfo(summonerName: summName);
}
