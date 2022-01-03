import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sample_project/data/station.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StationApi {
  final API_KEY = dotenv.env['API_KEY'];
  final BASE_URL = "http://openapi.seoul.go.kr:8088";

  Future<List<Station>> getSubwayStation(String stationName) async {
    Uri url = Uri.parse("$BASE_URL/$API_KEY/json/SearchSTNBySubwayLineInfo/1/5/ /${Uri.encodeQueryComponent(stationName)}");

    final response = await http.get(url);

    List<Station> data = [];

    if(response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      var res = json.decode(body) as Map<String, dynamic>;
      if (res["SearchSTNBySubwayLineInfo"]["RESULT"]["CODE"] != "INFO-000"){
        return [];
      }
      for(final _res in res["SearchSTNBySubwayLineInfo"]["row"]){
        final s = Station.fromJson(_res as Map<String, dynamic>);
        data.add(s);
      }
      return data;
    } else {
      return [];
    }
  }
}