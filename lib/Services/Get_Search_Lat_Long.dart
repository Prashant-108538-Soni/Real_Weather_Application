import 'package:flutter/foundation.dart';
import 'package:real_weather_application/Model/Search_Model.dart';
import 'package:real_weather_application/Services/SearchUrlGenerator.dart';
import 'package:http/http.dart' as http;

import '../Internal_Storage/boxes.dart';

class GetSearchLongLat {
  GetSearchLongLat();

  List<double> listLatLong = [];

  Future<List<double>> getSearchLatLong() async {
    String url = SearchUrlGenerator().getSearchUrl();
    var client = http.Client();
    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      final json = await compute(apiClassFromJson, response.body);
      double lat = json[0].lat;
      double lon = json[0].lon;
      listLatLong.add(lat);
      listLatLong.add(lon);
    }
    return listLatLong;
  }

  Future<List<double>> getFavLatLong() async {
    List<double> listFavLatLong = [];
    final box = Boxes.getFavData();
    var data = box.values.toList();
    int len = data.length;
    if (len == 0) {
      box.add("Patna");
      data = box.values.toList();
      len = data.length;
    }
    String favCityName = data[len - 1].toString();
    String url =
        "https://api.openweathermap.org/geo/1.0/direct?q=$favCityName&limit=5&appid=42b445fd3250ad7631256fd3d3163085";
    var client = http.Client();
    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      final json = await compute(apiClassFromJson, response.body);

      double lat = json[0].lat;
      double lon = json[0].lon;

      listFavLatLong.add(lat);
      listFavLatLong.add(lon);
    }
    return listFavLatLong;
  }
}
