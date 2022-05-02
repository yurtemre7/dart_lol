import 'package:dart_lol/LeagueStuff/responses/league_response.dart';
import 'package:dart_lol/dart_lol_api.dart';

class ApiCall {
  int time = 0;
  APIType apiType = APIType.summoner;
  String url = "";

  bool isOffendingCall = false;
  String? puuid = "";
  String? summonerId = "";
  String? tier = "";
  String? division = "";

  LeagueResponse leagueResponse = LeagueResponse();

  ApiCall(
      {required this.time, required this.apiType, required this.url, this.puuid, this.summonerId, this.tier, this.division, this.isOffendingCall = false, this.leagueResponse = LeagueResponse()});
}
