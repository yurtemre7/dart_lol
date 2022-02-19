import 'dart:convert';
import 'package:dart_lol/LeagueStuff/league_entry_dto.dart';
import 'package:localstorage/localstorage.dart';

import 'dart_lol_api.dart';

class LolStorage {
  final _summonerStorage = new LocalStorage('summoners_storage');
  final _matchHistoryStorage = new LocalStorage('match_histories');
  final _matchStorage = new LocalStorage('matches');

  final _rankedChallengerSoloStorage = new LocalStorage('ranked_challenger_solo');
  final _rankedGrandmasterSoloStorage = new LocalStorage('ranked_grandmaster_solo');
  final _rankedMasterSoloStorage = new LocalStorage('ranked_master_solo');
  final _rankedDiamondSoloStorage = new LocalStorage('ranked_diamond_solo');
  final _rankedPlatinumSoloStorage = new LocalStorage('ranked_platinum_solo');
  final _rankedGoldSoloStorage = new LocalStorage('ranked_gold_solo');
  final _rankedSilverSoloStorage = new LocalStorage('ranked_silver_solo');
  final _rankedBronzeSoloStorage = new LocalStorage('ranked_bronze_solo');
  final _rankedIronSoloStorage = new LocalStorage('ranked_iron_solo');

  Future saveRankedPlayers(String tier, String division, int page, String challengerJson) async {
    if(tier == TiersHelper.getValue(Tier.CHALLENGER)) {
      await _rankedChallengerSoloStorage.setItem("$division-$page", challengerJson);
    }
  }

  List<LeagueEntryDto> getRankedPlayers(String tier, String division) {
    LocalStorage myStorage;
    if(tier == TiersHelper.getValue(Tier.CHALLENGER)) {
      myStorage = _rankedChallengerSoloStorage;
    }else {
      myStorage = _rankedChallengerSoloStorage;
    }
    bool keepSearching = true;
    int pageNumber = 1;
    List<LeagueEntryDto> list = [];
    final newPlayers = myStorage.getItem("$division-$pageNumber");
    if(newPlayers == null) {
      return list;
    }
    while(keepSearching) {
      final newPlayers = myStorage.getItem("$division-$pageNumber");

      if (newPlayers == null) {
        keepSearching = false;
      }else {
        final myLeagueEntryForThisPage = leagueEntryDtoFromJson(newPlayers);
        list.addAll(myLeagueEntryForThisPage);
        pageNumber++;
      }
    }
    return list;
  }



  Map<String, dynamic>? getSummoner(String summonerName) {
    final that = _summonerStorage.getItem("$summonerName");
    if(that == null) {
      return null;
    }
    return json.decode(that);
  }

  Future saveSummoner(String summonerName, String summonerJson) async {
    await _summonerStorage.setItem(summonerName, summonerJson);
  }

  Map<String, dynamic> getMatch(String matchId) {
    final matchString = _matchStorage.getItem("$matchId");
    if(matchString == null)
      return {};
    else return json.decode(matchString);
  }

  saveMatch(String matchId, String matchJson) async {
    await _matchStorage.setItem(matchId, matchJson);
  }

  List<dynamic> getMatchHistories(String puuid) {
    final matchHistoriesString = _matchHistoryStorage.getItem(puuid);
    if (matchHistoriesString == null)
      return <dynamic>[];
    else return json.decode(matchHistoriesString);
  }

  /// 1. Get old match histories
  /// 2. Convert new match histories
  /// 3. Add 1 and 2 to a Set
  /// 4. Save Set to local storage
  saveMatchHistories(String puuid, String myJson) async {
    final oldMatches = getMatchHistories(puuid);
    final newMatches = json.decode(myJson);
    print("${newMatches.length} new matches");
    /// Prevent duplicates
    Set<String> matchesSet = {};
    oldMatches.forEach((element) {
      matchesSet.add(element);
    });
    newMatches.forEach((element) {
      matchesSet.add(element);
    });
    print("${matchesSet.length} total matches");
    final that = matchesSet.toList();
    String theJson = jsonEncode(that);
    await _matchHistoryStorage.setItem(puuid, theJson);
  }
}
