import 'package:real_weather_application/Services/Fetch_API.dart';
import 'package:real_weather_application/Services/Url_Generator.dart';

class GetFinalApiData
{
  late String url;
  Future<dynamic> getFinalWeatherData()
  async {
     url = await UrlGenerator().getUrl();
    FetchApi fetchApi = FetchApi(url);
    var weatherData = fetchApi.getWeatherData();
    return weatherData;
  }

}