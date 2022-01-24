library dart_lol;

import 'dart:convert';
import 'package:dart_lol/LeagueStuff/game_stats.dart';
import 'package:http/http.dart' as http;

import 'LeagueStuff/champion_mastery.dart';
import 'LeagueStuff/game.dart';
import 'LeagueStuff/rank.dart';
import 'LeagueStuff/summoner.dart';

class League {
  /// This is the api-token you need to insert in order to use the League()
  /// instance and therefore the hole package xD!
  String apiToken;

  /// A string representation of the server, you want to get data from.
  ///
  /// e.g. "EUW1" for Europe West or "NA1" for North America.
  String? server;

  Map<String, String> serverMap = {
    'na1': 'americas',
    'br1': 'americas',
    'la1': 'americas',
    'la2': 'americas',
    'oc1': 'americas',
    'euw1': 'europe',
    'eun1': 'europe',
    'tr1': 'europe',
    'ru': 'europe',
    'kr': 'asia',
    'jp1': 'asia',
  };

  /// List contains every champion with their according mastery stat.
  List<ChampionMastery>? champMasteriesList;
  List<Game>? gameList;

  /// Class League() instance to use to get several
  /// information about an player.
  /// Requiers an api-token from the official
  /// League developer page:
  /// * https://developer.riotgames.com/
  ///
  /// e.g. "EUW1" for Europe West or "NA1" for North America.
  League({required this.apiToken, required String server}) {
    this.server = server.toLowerCase();
  }

  /// Get an Future instance of the Summoner() class.
  /// So use the
  /// ```
  /// .then(onValue){
  ///
  /// }
  /// ```
  /// method to get their name, account id, level and revision date.
  Future<Summoner> getSummonerInfo({String? summonerName}) async {
    var url =
        'https://$server.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerName?api_key=$apiToken';
    var response = await http.get(
      Uri.parse(url),
    );
    print(response.body);
    return Summoner.fromJson(
      json.decode(
        response.body,
      ),
    );
  }

  /// Get an Future instance of the ChampionMasteries class.
  /// So use the
  /// ```
  /// .then(onValue){
  ///
  /// }
  /// ```
  /// method to get their champion name, level and if chest aquired.
  Future<List<ChampionMastery>?> getChampionMasteries({String? summonerID}) async {
    var url =
        'https://$server.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/$summonerID?api_key=$apiToken';
    var response = await http.get(
      Uri.parse(url),
    );
    var championMasteries = json.decode(
      response.body,
    );

    champMasteriesList = [];
    championMasteries.forEach(
      (championMastery) {
        champMasteriesList!.add(
          ChampionMastery.fromJson(
            json.decode(json.encode(championMastery)),
          ),
        );
      },
    );

    return champMasteriesList;
  }

  /// Get an Future instance of the Game class as a List of it.
  /// So use the
  /// ```
  /// .then(onValue){
  ///   onValue[x]  //where x is the game you want (0 most-recent)
  /// }
  /// ```
  /// method to get their champion name, level and if chest aquired.
  Future<List<Game>?> getGameHistory({String? accountID, String? summonerName}) async {
    var url =
        'https://${serverMap[server]}.api.riotgames.com/lol/match/v4/matchlists/by-account/$accountID?api_key=$apiToken';
    var response = await http.get(
      Uri.parse(url),
    );
    final matchList = json.decode(response.body)['matches'];
    gameList = [];
    matchList.forEach(
      (game) {
        gameList!.add(
          Game.fromJson(json.decode(json.encode(game)), this.apiToken, summonerName, this.server),
        );
      },
    );
    return gameList;
  }

  Future<List<Game>?> getGameHistory2(
      {required String puuid, required String summonerName, int start = 0, int count = 20}) async {
    var url =
        'https://${serverMap[server]}.api.riotgames.com/lol/match/v5/matches/by-puuid/$puuid/ids?start=$start&count=$count&api_key=$apiToken';
    var response = await http.get(
      Uri.parse(url),
    );
    final matchIdList = json.decode(response.body);
    print(matchIdList);
    gameList = [];
    for (String id in matchIdList) {
      var url = 'https://${serverMap[server]}.api.riotgames.com/lol/match/v5/matches/$id?api_key=$apiToken';
      var response = await http.get(
        Uri.parse(url),
      );
      final match = json.decode(response.body);
      print("\nID: $id");
      print(match);
      print("---");
      gameList!.add(
        Game.fromJson(json.decode(json.encode(match)), this.apiToken, summonerName, this.server),
      );
    }

    return gameList;
  }

  Future<Rank> getRankInfos({String? summonerID}) async {
    var url =
        'https://$server.api.riotgames.com/lol/league/v4/entries/by-summoner/$summonerID?api_key=$apiToken';
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.body.toString() != '[]') {
      return Rank.fromJson(
        json.decode(
          response.body,
        )[0],
      );
    } else {
      return Rank(
          hotStreak: false,
          leagueId: '0',
          leaguePoints: 0,
          losses: 0,
          wins: 0,
          rank: 'unranked',
          tier: 'no tier');
    }
  }

  Future<GameStat?> getCurrentGame({String? summonerID, String? summonerName}) async {
    var url =
        'https://$server.api.riotgames.com/lol/spectator/v4/active-games/by-summoner/$summonerID?api_key=$apiToken';
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode != 404) {
      return GameStat.fromJson(
        json.decode(
          response.body,
        ),
        summonerName,
        summonerID,
      );
    }
    return null;
  }
}
