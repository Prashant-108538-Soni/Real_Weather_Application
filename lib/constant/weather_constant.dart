import '../Internal_Storage/boxes.dart';

class WeatherConstant {
  final box = Boxes.getFavData();

  static String cityName = "Patna";

  String getCityName() {
    return cityName;
  }
}
