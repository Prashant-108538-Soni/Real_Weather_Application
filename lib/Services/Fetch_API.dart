import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:real_weather_application/Model/weather_model.dart';

class FetchApi {
  final String url;
  FetchApi(this.url);

  Future getWeatherData() async {
    var client = http.Client();
    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      final json = await compute(apiClassFromJson, response.body);
      if (kDebugMode) {
        print("return from Fetch Api");
      }
      return json;
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }
}
