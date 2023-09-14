class SearchUrlGenerator {
  SearchUrlGenerator();
  static String searchUrl =
      "https://api.openweathermap.org/geo/1.0/direct?q=Bokaro&limit=5&appid=42b445fd3250ad7631256fd3d3163085";

  void setSearchUrl(String cityName) {
    searchUrl =
        "https://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=5&appid=42b445fd3250ad7631256fd3d3163085";
  }

  String getSearchUrl() {
    return searchUrl;
  }
}
