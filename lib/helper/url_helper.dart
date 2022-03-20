import 'dart:io';
import 'dart:math';

import 'package:dart_lol/ddragon_api.dart';
import 'package:dart_lol/ddragon_storage.dart';
import 'package:get_it/get_it.dart';

import '../LeagueStuff/runes_reforged.dart';
import '../LeagueStuff/summoner_spells.dart';
import '../ddragon_storage.dart';

class UrlHelper {
  final DDRAGON_BASE = "https://ddragon.leagueoflegends.com/";
  var apiKey = "";

  GetIt getIt = GetIt.instance;
  DDragonStorage dDragonStorage = DDragonStorage();

  UrlHelper() {
    getIt.registerSingleton<DDragonStorage>(dDragonStorage);
  }

  //return "12.2.1";
  String getRiotGamesAPIVersion() {
    return dDragonStorage.currentVersion;
  }

  //https://ddragon.leagueoflegends.com/api/versions.json
  String returnVersionsUrl() {
    return "${DDRAGON_BASE}api/versions.json";
  }

  //http://ddragon.leagueoflegends.com/cdn/9.11.1/data/en_US/champion.json
  String buildChampions() {
    return "${DDRAGON_BASE}cdn/${getRiotGamesAPIVersion()}/data/en_US/champion.json";
  }

  //http://ddragon.leagueoflegends.com/cdn/12.4.1/data/en_US/champion/Aatrox.json
  String buildChampionStandAlone(String championName) {
    return "${DDRAGON_BASE}cdn/${getRiotGamesAPIVersion()}/data/en_US/champion/$championName.json";
  }

  //https://ddragon.leagueoflegends.com/cdn/img/champion/splash/${controller.matchItem.value.championName}_3.jpg
  String buildChampionSplashImage(String championName, int number) {
    return "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/${championName}_$number.jpg";
  }

  String buildChampionImage(String imageEnding) {
    if(!imageEnding.contains(".png")) {
      imageEnding += ".png";
    }
    return "${DDRAGON_BASE}cdn/${getRiotGamesAPIVersion()}/img/champion/$imageEnding";
  }

  /// Profile Icon
  String buildProfileIcon(int iconId) {
    return "$DDRAGON_BASE/cdn/${getRiotGamesAPIVersion()}/img/profileicon/$iconId.png";
  }

  String buildItemImage(String full) {
    if(!full.contains(".png"))
      full += ".png";
    return "${DDRAGON_BASE}cdn/${getRiotGamesAPIVersion()}/img/item/$full";
  }

  //https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Fizz_1.jpg
  String buildSplashArt(String name) {
    return "${DDRAGON_BASE}cdn/img/champion/splash/${name}_1.jpg";
  }

  //https://ddragon.leagueoflegends.com/cdn/img/champion/splash/${controller.matchItem.value.championName}_3.jpg
  Future<String> returnRandomChampionSplash(String name) async {
    final championStandalone = await dDragonStorage.getChampionStandAloneFromDb("$name");
    final numberSkins = championStandalone.data?.aatrox?.skins?.length??0;
    final skinRandomNumber = Random().nextInt(numberSkins);
    final skinNumber = championStandalone.data?.aatrox?.skins?[skinRandomNumber].num;
    return buildChampionSplashImage(name, skinNumber??1);
  }

  //http://ddragon.leagueoflegends.com/cdn/12.5.1/data/en_US/summoner.json
  String buildSummonerSpellsApiCall() {
    return "${DDRAGON_BASE}cdn/${getRiotGamesAPIVersion()}/data/en_US/summoner.json";
  }

  //https://ddragon.leagueoflegends.com/cdn/12.5.1/img/spell/SummonerPoroThrow.png
  String buildSummonerSpellImage(int myKey) {
    var summonerSpells = GetIt.instance<SummonerSpell>();
    var url = "${DDRAGON_BASE}cdn/${getRiotGamesAPIVersion()}/img/spell/SummonerBarrier.png";;
    summonerSpells.data?.forEach((key, value) {
      if("$myKey" == value.key) {
        url = "${DDRAGON_BASE}cdn/${getRiotGamesAPIVersion()}/img/spell/${value.image.full}";
        return;
      }
    });
    return url;
  }

  //https://ddragon.leagueoflegends.com/cdn/12.5.1/data/en_US/runesReforged.json
  String buildRunesApiCall() {
    return "${DDRAGON_BASE}cdn/${getRiotGamesAPIVersion()}/data/en_US/runesReforged.json";
  }

  String buildRuneImage(int id) {
    var runesReforged = GetIt.instance<List<RunesReforged>>();
    final rune = runesReforged.firstWhere((element) => element.id == id);
    return "${DDRAGON_BASE}cdn/img/${rune.icon}";
  }

  /** na1. api **/
  //https://na1.api.riotgames.com/lol/league/v4/challengerleagues/by-queue/RANKED_SOLO_5x5
  String buildChallengerLeagueByQueue(String queue) {
    return "league/v4/challengerleagues/by-queue/RANKED_SOLO_5x5?api_key=$apiKey";
  }

  String buildGrandmasterLeagueByQueue(String queue) {
    return "league/v4/grandmasterleagues/by-queue/RANKED_SOLO_5x5?api_key=$apiKey";
  }

  //https://na1.api.riotgames.com/lol/league/v4/entries/by-summoner/p0AX3fC5pERFzCffvHAUwGU72cLtauy1-jcktSdTCyUpMI4
  String buildLeague(String id) {
    return "league/v4/entries/by-summoner/$id?api_key=$apiKey";
  }
}
