import 'package:dart_lol/dart_lol.dart';
import 'package:dart_lol/key.dart';

var emre = 'teemo ist op';

main() async {
  final league = League(apiToken: key, server: 'euw1');
  // print(league.server);
  var summonerInfo = await league.getSummonerInfo(summonerName: emre);

  DateTime lastOnline = summonerInfo.lastTimeOnline!;
  print(lastOnline);
  print(summonerInfo.summonerName);
  // Outputs "teemo ist op"
  print(summonerInfo.level);
  // Outputs current summoner level

  // etc.
  var games =
      await league.getGameHistory2(puuid: summonerInfo.puuid!, summonerName: summonerInfo.summonerName!);
  var game1Stats = await games![0].stats();
  // print(game1Stats);
}
