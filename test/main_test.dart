import 'package:dart_lol/dart_lol_db.dart';
import 'package:dart_lol/key.dart';
import 'package:flutter_test/flutter_test.dart';

var emre = 'teemo ist op';

main() async {
  test('summoner test', () async {
    final league = LeagueDB(apiToken: key, server: 'euw1');
    // print(league.server);
    var response = await league.getSummonerFromAPI(emre);
    var summoner = response.summoner;
    expect(summoner, isNotNull);
    summoner = summoner!;

    var lastTimeOnline = summoner.revisionDate;
    lastTimeOnline = lastTimeOnline!;
    var onlineDate = DateTime.fromMillisecondsSinceEpoch(lastTimeOnline);
    print('Last time online: ' + onlineDate.toString());
    print('Your name: ${summoner.name}');
    print('Your level ${summoner.summonerLevel}');

    String puuid = summoner.puuid!;
    var games = await league.getMatchesFromAPI(puuid, count: 1);
    expect(games.matchOverviews, isNotNull);
    expect(games.matchOverviews!, isNotEmpty);
    String matchId = (games.matchOverviews?.first)!;

    var game = await league.getMatch(matchId);
    expect(game.match, isNotNull);
  });

  test('summoner currently in game test', () async {
    final league = LeagueDB(apiToken: key, server: 'euw1');
    var response = await league.getSummonerFromAPI(emre);
    var summoner = response.summoner;
    expect(summoner, isNotNull);
    summoner = summoner!;
    response = await league.getCurrentGame(summoner);
    print(response.responseCode);
    expect(response.match, isNull);
  });
}
