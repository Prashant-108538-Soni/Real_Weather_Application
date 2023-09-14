import 'dart:convert';

List<ApiClass> apiClassFromJson(String str) =>
    List<ApiClass>.from(json.decode(str).map((x) => ApiClass.fromJson(x)));

String apiClassToJson(List<ApiClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiClass {
  ApiClass({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    this.state,
  });

  String name;
  double lat;
  double lon;
  String country;
  String? state;

  factory ApiClass.fromJson(Map<String, dynamic> json) => ApiClass(
        name: json["name"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        country: json["country"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "lon": lon,
        "country": country,
        "state": state,
      };
}
