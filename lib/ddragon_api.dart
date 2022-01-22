import 'package:dart_lol/ddragon_storage.dart';
import 'package:http/http.dart' as http;
import 'package:dart_lol/helper/UrlHelper.dart';
import 'dart:convert';

import 'LeagueStuff/champions.dart';

class DDragonAPI {

  //https://ddragon.leagueoflegends.com/api/versions.json
  Future<List<String>> getVersionsFromApi() async {
    var url = UrlHelper().returnVersionsUrl();
    print("versions url: $url");
    final response = await http.get(Uri.parse(url));
    List<String> stringList = (json.decode(response.body) as List<dynamic>).cast<String>();
    DDragonStorage().saveVersions(stringList);
    return stringList;
  }

  //https://ddragon.leagueoflegends.com/cdn/12.2.1/data/en_US/champion.json
  Future<Champions> getChampionsFromApi() async {
    final url = await UrlHelper().buildChampions();
    print("champions url: $url");
    final response = await http.get(Uri.parse(url));
    final list = json.decode(response.body);
    DDragonStorage().saveChampions(response.body);
    return Champions.fromJson(list);
  }
}
