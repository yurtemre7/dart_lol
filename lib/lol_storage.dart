import 'dart:convert';
import 'package:dart_lol/LeagueStuff/league_entry_dto.dart';
import 'package:localstorage/localstorage.dart';

class LolStorage {
  final summonerStorage = new LocalStorage('summoners');
  final matchHistoryStorage = new LocalStorage('match_histories');
  final matchStorage = new LocalStorage('matches');

  final rankedChallengerSoloStorage = new LocalStorage('ranked_challenger_solo');

  saveChallenger(String division, int page, String challengerJson) {
    rankedChallengerSoloStorage.setItem("$division-$page", challengerJson);
  }

  List<LeagueEntryDto> getChallengerPlayers(String division) {
    bool keepSearching = true;
    int pageNumber = 1;
    List<LeagueEntryDto> list = [];
    while(keepSearching) {
      final newPlayers = rankedChallengerSoloStorage.getItem("$division-$pageNumber");

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

  Map<String, dynamic> getSummoner(String summonerName) {
    return json.decode(summonerStorage.getItem(summonerName));
  }

  saveSummoner(String summonerName, String summonerJson) {
    summonerStorage.setItem(summonerName, summonerJson);
  }

  Map<String, dynamic> getMatch(String matchId) {
    final matchString = matchStorage.getItem("$matchId");
    if(matchString == null)
      return {};
    else return json.decode(matchString);
  }

  saveMatch(String matchId, String matchJson) {
    matchStorage.setItem(matchId, matchJson);
  }

  List<dynamic> getMatchHistories(String puuid) {
    final matchHistoriesString = matchHistoryStorage.getItem(puuid);
    if (matchHistoriesString == null)
      return <dynamic>[];
    else return json.decode(matchHistoriesString);
  }

  /// 1. Get old match histories
  /// 2. Convert new match histories
  /// 3. Add 1 and 2 to a Set
  /// 4. Save Set to local storage
  saveMatchHistories(String puuid, String myJson) {
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
    matchHistoryStorage.setItem(puuid, theJson);
  }
}
