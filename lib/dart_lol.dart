library dart_lol;

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'LeagueStuff/champion_mastery.dart';
import 'LeagueStuff/game.dart';
import 'LeagueStuff/rank.dart';
import 'LeagueStuff/summoner.dart';

class League {
  /// This is the api-token you need to insert in order to use the League()
  /// instance and therefore the hole package xD!
  String apiToken;

  /// List contains every champion with their according mastery stat.
  List<ChampionMastery> champMasteriesList;
  List<Game> gameList;

  /// Class League() instance to use to get several
  /// information about an player.
  /// Requiers an api-token from the official
  /// League developer page:
  /// * https://developer.riotgames.com/
  League({this.apiToken});

  /// Get an Future instance of the Summoner() class.
  /// So use the
  /// ```
  /// .then(onValue){
  ///
  /// }
  /// ```
  /// method to get their name, account id, level and revision date.
  Future<Summoner> getSummonerInfo({String summonerName}) async {
    var url =
        'https://euw1.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerName?api_key=$apiToken';
    var response = await http.get(
      url,
    );
    //print(response.body);
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
  Future<List<ChampionMastery>> getChampionMasteries(
      {String summonerID}) async {
    var url =
        'https://euw1.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/$summonerID?api_key=$apiToken';
    var response = await http.get(
      url,
    );
    var championMasteries = json.decode(
      response.body,
    );

    champMasteriesList = [];
    championMasteries.forEach(
      (championMastery) {
        // print each champion mastery json
        //print(json.encode(championMastery));
        champMasteriesList.add(
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
  Future<List<Game>> getGameHistory({String accountID, String summonerName}) async {
    var url =
        'https://euw1.api.riotgames.com/lol/match/v4/matchlists/by-account/$accountID?api_key=$apiToken';
    var response = await http.get(
      url,
    );
    final matchList = json.decode(response.body)['matches'];
    gameList = [];
    matchList.forEach(
      (game) {
        gameList.add(
          Game.fromJson(json.decode(json.encode(game)), apiToken, summonerName),
        );
      },
    );
    return gameList;
  }

  Future<Rank> getRankInfos({String summonerID}) async {
    var url =
        'https://euw1.api.riotgames.com/lol/league/v4/entries/by-summoner/$summonerID?api_key=$apiToken';
    var response = await http.get(
      url,
    );
    if (response.body.toString() != '[]') {
      return Rank.fromJson(
        json.decode(
          response.body,
        )[0],
      );
    }else{
      return Rank(hotStreak: false, leagueId: '0', leaguePoints: 0, losses: 0, wins: 0, rank: 'unranked', tier: 'no tier');
    }
  }
}
