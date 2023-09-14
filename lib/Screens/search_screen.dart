import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:real_weather_application/Internal_Storage/boxes.dart';
import 'package:real_weather_application/Model/History_model.dart';
import 'package:real_weather_application/Services/Get_Search_Lat_Long.dart';
import 'package:real_weather_application/Services/SearchUrlGenerator.dart';
import 'package:real_weather_application/Services/Url_Generator.dart';
import 'package:intl/intl.dart';
import 'package:real_weather_application/constant/weather_constant.dart';
import '../Provider/weather_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather Forecast",
          style: TextStyle(fontSize: MediaQuery.of(context).size.width / 3),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    controller: _controller,
                    cursorColor: Colors.black87,
                    decoration: InputDecoration(
                        fillColor: Colors.purple[50],
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: 'Search',
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 18),
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(15),
                          width: 18,
                          child: const Icon(Icons.search),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                          },
                        )),
                    onSubmitted: (String value) async {
                      WeatherConstant.cityName = value;
                      // set Value of city Name that user entered in search Bar....

                      SearchUrlGenerator().setSearchUrl(value);
                      // Generate search url according to name search by user....

                      List<double> list =
                          await GetSearchLongLat().getSearchLatLong();
                      // Get Value of latitude and longitude of place that user entered in search field....

                      double lat = list[0];
                      double lon = list[1];
                      UrlGenerator().setUrl(lat, lon);
                      // Set value of lat and long in url generator class for generating url.

                      await Provider.of<WeatherProvider>(context, listen: false)
                          .getAllListElement();
                      // Receive list element from weather provider

                      final searchcityWeather =
                          await Provider.of<WeatherProvider>(context,
                                  listen: false)
                              .listElement;

                      // Extract required data like city name , temp , icon id, timezone

                      String cityName =
                          Provider.of<WeatherProvider>(context, listen: false)
                              .cityName;
                      String iconData = searchcityWeather[0].weather[0].icon;
                      String tempMax =
                          searchcityWeather[0].main.tempMax.toString();
                      String tempMin =
                          searchcityWeather[0].main.tempMin.toString();
                      String currentDate =
                          DateFormat("yyyy-MM-dd").format(DateTime.now());
                      String currentTime =
                          DateFormat("hh:mm:ss a").format(DateTime.now());
                      // Code to save search data in Hive........
                      final data = HistoryModel(cityName, tempMin, tempMax,
                          iconData, currentDate, currentTime);
                      final box = Boxes.getData();
                      box.add(data);
                      data.save();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              children: const [Text("Recent")],
            ),
            const SizedBox(
              height: 30,
            ),
            ValueListenableBuilder<Box<HistoryModel>>(
              valueListenable: Boxes.getData().listenable(),
              builder: (context, box, _) {
                var data = box.values.toList().cast<HistoryModel>();
                return Flexible(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                  "assets/weatherImage/${data[index].iconId}.png"),
                            ),
                            title: Text(data[index].cityName.toString()),
                            subtitle: Text(
                                "${data[index].minTemp}°C/${data[index].minTemp}°C"),
                            trailing: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    data[index].cTime,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Text(data[index].cDate)
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.purple,
                            thickness: 2,
                            height: 2,
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
