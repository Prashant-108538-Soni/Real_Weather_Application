import 'package:flutter/foundation.dart';
import 'package:real_weather_application/Services/Get_Search_Lat_Long.dart';

class UrlGenerator {
  static int count = 1;
  static var endpoint = "https://api.openweathermap.org/data/2.5/forecast?";
  static var apikey = "42b445fd3250ad7631256fd3d3163085";

  static String url =
      "https://api.openweathermap.org/data/2.5/forecast?lat=25.594093333333333&lon=85.13756333333333&appid=42b445fd3250ad7631256fd3d3163085&units=metric";
  void setUrl(double lat, double lon) {
    url = "${endpoint}lat=$lat&lon=$lon&appid=$apikey&units=metric";
  }

  Future<String> getUrl() async {
    if (count == 1) {
      List<double> list = await GetSearchLongLat().getFavLatLong();
      double lat = list[0];
      double lon = list[1];
      count++;
      return "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=42b445fd3250ad7631256fd3d3163085&units=metric";
    }
    if (kDebugMode) {
      print("From Url Generator$url");
    }
    return url;
  }
}
