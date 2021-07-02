import 'package:dart_lol/dart_lol.dart';
import 'package:dart_lol/key.dart';

var emre = 'buff yi rep mid';

main() async {
  final league = League(apiToken: key, server: 'euw1');
  // print(league.server);
  var summonerInfo = await league.getSummonerInfo(summonerName: emre);

  print(summonerInfo.lastTimeOnline);

  print(summonerInfo.summonerName);
  // Outputs buff yi rep mid
  print(summonerInfo.level);
  // Outputs current summoner level

  // etc.
  var games = await league.getGameHistory(
      accountID: summonerInfo.accID, summonerName: summonerInfo.summonerName);
  var game1Stats = await games![0].stats();
  print(game1Stats.participants![game1Stats.playerIDinGame! - 1].championName);

  var game2Stats = await games[1].stats();
  print(game2Stats.participants![game2Stats.playerIDinGame! - 1].championName);
}
