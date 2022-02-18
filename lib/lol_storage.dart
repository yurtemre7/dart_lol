import 'dart:convert';
import 'package:dart_lol/LeagueStuff/league_entry_dto.dart';
import 'package:localstorage/localstorage.dart';

class LolStorage {
  final _summonerStorage = new LocalStorage('summoners_storage');
  final _matchHistoryStorage = new LocalStorage('match_histories');
  final _matchStorage = new LocalStorage('matches');

  final _rankedChallengerSoloStorage = new LocalStorage('ranked_challenger_solo');

  Future saveChallenger(String division, int page, String challengerJson) async {
    await _rankedChallengerSoloStorage.setItem("$division-$page", challengerJson);
  }

  List<LeagueEntryDto> getChallengerPlayers(String division) {
    bool keepSearching = true;
    int pageNumber = 1;
    List<LeagueEntryDto> list = [];
    while(keepSearching) {
      final newPlayers = _rankedChallengerSoloStorage.getItem("$division-$pageNumber");

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
