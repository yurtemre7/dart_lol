import 'package:dart_lol/ddragon_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:dart_lol/helper/UrlHelper.dart';
import 'dart:convert';

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
    final url = await urlHelper.buildChampions();
    final response = await http.get(Uri.parse(url));
    final list = json.decode(response.body);
    var dDragonStorage = GetIt.instance<DDragonStorage>();
    dDragonStorage.saveChampions(response.body);
    return Champions.fromJson(list);
  }

}
