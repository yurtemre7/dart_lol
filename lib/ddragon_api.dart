import 'package:http/http.dart' as http;
import 'package:dart_lol/helper/UrlHelper.dart';
import 'dart:convert';

class DDragonAPI {

  //https://ddragon.leagueoflegends.com/api/versions.json
  Future<List<String>> getVersions() async {
    var url = UrlHelper().returnVersionsUrl();
    print("url: $url");
    final response = await http.get(Uri.parse(url));
    List<String> stringList = (json.decode(response.body) as List<dynamic>).cast<String>();
    print(stringList);
    return stringList;
  }




}