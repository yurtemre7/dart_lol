import 'dart:convert';

import 'package:dart_lol/LeagueStuff/Queues.dart';
import 'package:dart_lol/LeagueStuff/champion_stand_alone.dart';
import 'package:dart_lol/LeagueStuff/runes_reforged.dart';
import 'package:dart_lol/LeagueStuff/summoner_spells.dart';
import 'package:localstorage/localstorage.dart';

import 'LeagueStuff/champions.dart';
import 'ddragon_api.dart';

class DDragonStorage {
  final dDragonLocalStorage = new LocalStorage('ddragon_storage');
  final versionsKey = "ddragon_versions";
  final versionsLastSaved = "versions_last_saved";
  var currentVersion = "";

  /// VERSIONS
  Future saveVersions(List<String> versions) async {
    await dDragonLocalStorage.setItem(versionsKey, versions);
    await dDragonLocalStorage.setItem(versionsLastSaved, DateTime.now().millisecondsSinceEpoch);
  }

  Future<int> getVersionsLastUpdated() async {
    return await dDragonLocalStorage.getItem(versionsLastSaved);
  }

  Future<String> getVersionFromDb() async {
    print("Getting versions from db");
    if(currentVersion != "") {
      print("versions not equal to '': $currentVersion");
      return currentVersion;
    }
    final version = await dDragonLocalStorage.getItem(versionsKey);
    if(version == null) {
      final versionAPI = await DDragonAPI().getVersionsFromApi();
      currentVersion = versionAPI[0];
      print("version received from api: $currentVersion");
      return currentVersion;
    }
    currentVersion = version[0];
    print("version received from db: $currentVersion");
    return currentVersion;
  }

  /// Champions all
  final championsKey = "champions_key";
  final championsLastSaved = "champions_last_saved";
  saveChampions(String champions) {
    dDragonLocalStorage.setItem(championsKey, champions);
    dDragonLocalStorage.setItem(championsLastSaved, DateTime.now().millisecondsSinceEpoch);
  }

  int getChampionsLastUpdated() {
    return dDragonLocalStorage.getItem(championsLastSaved);
  }

  Future<Champions> getChampionsFromDb() async {
    final championsString = await dDragonLocalStorage.getItem(championsKey);
    if(championsString == null)
      return await DDragonAPI().getChampionsFromApi();
    return Champions.fromJson(json.decode(championsString));
  }
  /// Champions all end

  /// Champions Specific
  saveSpecificChampion(String json, String championName) {
    dDragonLocalStorage.setItem("$championsKey-$championName", json);
  }

  Future<ChampionStandAlone> getChampionStandAloneFromDb(String championName) async {
    final championsString = await dDragonLocalStorage.getItem("$championsKey-$championName");
    if(championsString == null) {
      print("Champion data not in db, calling API for specific champion data");
      return await DDragonAPI().getSpecificChampionFromApi(championName);
    }
    final championStandAlone = ChampionStandAlone.fromJson(json.decode(championsString), championName);
    print("comparing version ${championStandAlone.version} vs $currentVersion");
    if(championStandAlone.version != currentVersion) {
      print("Champion data out of date, calling API for specific champion data");
      return await DDragonAPI().getSpecificChampionFromApi(championName);
    }
    return championStandAlone;
  }
  /// Champions Specific end
  final spellKey = "summoner_spells";
  Future<SummonerSpell> getSummonerSpellsFromDb() async {
    final spellString = await dDragonLocalStorage.getItem(spellKey);
    if(spellString == null) {
      print("summoner spells not in database, getting them from api");
      return await DDragonAPI().getSummonerSpellsFromApi();
    }
    final summonerSpells = SummonerSpell.fromJson(json.decode(spellString));
    print("comparing version ${summonerSpells.version} vs $currentVersion");
    if(summonerSpells.version != currentVersion) {
      print("Summoner spell data out of date, calling API");
      return await DDragonAPI().getSummonerSpellsFromApi();
    }
    return summonerSpells;
  }

  saveSummonerSpells(String json) {
    dDragonLocalStorage.setItem(spellKey, json);
  }
  ///Get summoner spell stuff


  /// Runes
  final runeKey = "runes_reforged";
  final runeKeyDate = "runes_reforged_date";
  Future<List<RunesReforged>> getRunesFromDb() async {
    final runesString = await dDragonLocalStorage.getItem(runeKey);
    if(runesString == null) {
      print("runes not in database, getting them from api");
      return await DDragonAPI().getRunesFromApi();
    }
    // Check runes version
    final runesVersion = dDragonLocalStorage.getItem(runeKeyDate);
    if(runesVersion != currentVersion) {
      print("Runes version not equal to currentVersion ($runesVersion vs $currentVersion), calling api");
      return await DDragonAPI().getRunesFromApi();
    }
    return runesReforgedFromJson(json.decode(runesString));
  }

  saveRunesReforged(String json) {
    dDragonLocalStorage.setItem(runeKey, json);
    dDragonLocalStorage.setItem(runeKeyDate, currentVersion);
  }
  /// Runes

  /// Queues
  final queueKey = "queue_key";
  final queueVersion = "queue_key_version";
  Future<List<Queues>> getQueuesFromDb() async {
    final queueSavedVersion = await dDragonLocalStorage.getItem(queueVersion);
    final queueString = await dDragonLocalStorage.getItem(queueKey);
    if(currentVersion != queueSavedVersion || queueString == null) {
      return await DDragonAPI().getQueuesFromApi();
    }
    return queuesFromJson(json.decode(queueString));
  }

  saveQueuesToDb(String json) {
    dDragonLocalStorage.setItem(queueKey, json);
    dDragonLocalStorage.setItem(queueVersion, currentVersion);
  }
  /// Queues
}
