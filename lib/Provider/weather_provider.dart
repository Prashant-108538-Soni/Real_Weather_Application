import 'package:flutter/foundation.dart';
import 'package:real_weather_application/Services/Get_Final_Api_Data.dart';

import '../Model/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  final getFinalApiData = GetFinalApiData();
  bool isLoading = false;
  final List<ListElement> _listElement = [];
  late String localityName;

  List<ListElement> get listElement => _listElement;
  String get cityName => localityName;

  void setCity(String cityName) {
    localityName = cityName;
    if (kDebugMode) {
      print("From setCity $localityName");
    }
    notifyListeners();
  }

  Future<void> getAllListElement() async {
    isLoading = true;
    notifyListeners();

    final response = await getFinalApiData.getFinalWeatherData();
    _listElement.clear();
    _listElement.addAll(response.list.toList());
    if (kDebugMode) {
      print(_listElement.length);
    }
    setCity(response.city.name.toString());
    isLoading = false;
    notifyListeners();
  }
}
