import 'package:dart_lol/LeagueStuff/Queues.dart';
import 'package:dart_lol/LeagueStuff/runes_reforged.dart';
import 'package:dart_lol/LeagueStuff/summoner_spells.dart';
import 'package:dart_lol/ddragon_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:dart_lol/helper/url_helper.dart';
import 'dart:convert';

import 'LeagueStuff/champion_stand_alone.dart';
import 'LeagueStuff/champions.dart';

class DDragonAPI {

  //https://ddragon.leagueoflegends.com/api/versions.json
  Future<List<String>> getVersionsFromApi() async {
    var urlHelper = GetIt.instance<UrlHelper>();
    var url = urlHelper.returnVersionsUrl();
    final response = await http.get(Uri.parse(url));
    List<String> stringList = (json.decode(response.body) as List<dynamic>).cast<String>();
    var dDragonStorage = GetIt.instance<DDragonStorage>();
    dDragonStorage.saveVersions(stringList);
    return stringList;
  }

  //https://ddragon.leagueoflegends.com/cdn/12.2.1/data/en_US/champion.json
  Future<Champions> getChampionsFromApi() async {
    var urlHelper = GetIt.instance<UrlHelper>();
    final url = urlHelper.buildChampions();
    final response = await http.get(Uri.parse(url));
    final list = json.decode(response.body);
    var dDragonStorage = GetIt.instance<DDragonStorage>();
    dDragonStorage.saveChampions(response.body);
    return Champions.fromJson(list);
  }

  Future<ChampionStandAlone> getSpecificChampionFromApi(String championName) async {
    var urlHelper = GetIt.instance<UrlHelper>();
    final url = urlHelper.buildChampionStandAlone(championName);
    final response = await http.get(Uri.parse(url));
    final list = json.decode(response.body);
    var dDragonStorage = GetIt.instance<DDragonStorage>();
    dDragonStorage.saveSpecificChampion(response.body, championName);
    return ChampionStandAlone.fromJson(list, championName);
  }

  Future<SummonerSpell> getSummonerSpellsFromApi() async {
    var urlHelper = GetIt.instance<UrlHelper>();
    final url = urlHelper.buildSummonerSpellsApiCall();
    final response = await http.get(Uri.parse(url));
    final newResponse = response.body.replaceAll("null,", "");
    final list = json.decode(newResponse);
    var dDragonStorage = GetIt.instance<DDragonStorage>();
    dDragonStorage.saveSummonerSpells(newResponse);
    return SummonerSpell.fromJson(list);
  }

  Future<List<RunesReforged>> getRunesFromApi() async {
    var urlHelper = GetIt.instance<UrlHelper>();
    final url = urlHelper.buildRunesApiCall();
    final response = await http.get(Uri.parse(url));
    final newResponse = response.body.replaceAll("null,", "");
    var dDragonStorage = GetIt.instance<DDragonStorage>();
    dDragonStorage.saveRunesReforged(newResponse);
    return runesReforgedFromJson(newResponse);
  }

  //https://static.developer.riotgames.com/docs/lol/queues.json
  Future<List<Queues>> getQueuesFromApi() async {
    final url = "https://static.developer.riotgames.com/docs/lol/queues.json";
    final response = await http.get(Uri.parse(url));
    var dDragonStorage = GetIt.instance<DDragonStorage>();
    dDragonStorage.saveQueuesToDb(response.body);
    return queuesFromJson(response.body);
  }
}
