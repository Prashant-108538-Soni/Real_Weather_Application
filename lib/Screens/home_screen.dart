import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:like_button/like_button.dart';
import 'package:real_weather_application/Provider/weather_provider.dart';
import 'package:real_weather_application/Screens/search_screen.dart';
import 'package:real_weather_application/Services/Url_Generator.dart';
import 'package:real_weather_application/constant/weather_constant.dart';
import '../Internal_Storage/boxes.dart';
import '../Model/weather_model.dart';
import '../Services/Current_Location.dart';
import '../Widgets/Current_WeatherInfo_Widget.dart';
import '../Widgets/Daily_Forecast_Widget.dart';
import '../Widgets/Header_Data_Widget.dart';
import '../Widgets/Hourly_Forecast_Widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool flag = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<WeatherProvider>(context, listen: false).getAllListElement();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            //      Code to get current location weather..........
            flag = false;
            CurrentLocation location = CurrentLocation();
            Position position = await location.getCurrentPosition();
            double lat = position.latitude;
            double long = position.longitude;
            UrlGenerator().setUrl(lat, long);
            Provider.of<WeatherProvider>(context, listen: false)
                .getAllListElement();
          },
          icon: const Icon(
            Icons.location_on,
            size: 30,
          ),
        ),
        title: const Text(
          "Weather Forecast",
          style: TextStyle(fontStyle: FontStyle.normal),
        ),
        actions: [
          IconButton(
              onPressed: () {
                //  Code to navigate to search Page..........
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.search_outlined)),
          LikeButton(
            // Save Data  result in Database.....
            onTap: saveData(),
            size: 30,
            circleColor: const CircleColor(
                start: Color(0xff00ddff), end: Color(0xff0099cc)),
            bubblesColor: const BubblesColor(
              dotPrimaryColor: Color(0xff33b5e5),
              dotSecondaryColor: Color(0xff0099cc),
            ),
            likeBuilder: (bool isLiked) {
              return Icon(
                Icons.favorite,
                color: isLiked ? Colors.red : Colors.grey,
                size: 30,
              );
            },
          ),
        ],
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, object, child) {
          if (object.isLoading) {
            // While Data is loading .......
            return const Center(child: CircularProgressIndicator());
          }
          final List<ListElement> listDataFromApi = object.listElement;

          return ListView(children: [
            const SizedBox(
              height: 30,
            ),
            AppHeaderWidget(
                object.localityName,
                "${listDataFromApi[0].main.temp}",
                listDataFromApi[0].weather[0].icon),
            const SizedBox(
              height: 45,
            ),
            CurrentWeatherInfoWidget(
                "${listDataFromApi[0].wind.speed}",
                "${listDataFromApi[0].clouds.all}",
                "${listDataFromApi[0].main.humidity}"),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
              child: const Text(
                "Today",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width - 125,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (BuildContext context, index) {
                  return HourlyWidget(
                      "${listDataFromApi[index].main.temp}",
                      listDataFromApi[index].weather[0].icon,
                      "${listDataFromApi[index].dt}",
                      index);
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.all(12),
              height: 350,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text("Forecast for 7 days :",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: Colors.black,
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 250,
                    width: 400,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context, index) {
                        return DailyForecastWidget(
                            "${listDataFromApi[index * 8].dt}",
                            listDataFromApi[index * 8].weather[0].icon,
                            "${listDataFromApi[index * 8].main.tempMin}",
                            "${listDataFromApi[index * 8].main.tempMax}");
                      },
                    ),
                  ),
                ],
              ),
            )
          ]);
        },
      ),
    );
  }

  saveData() {
    String favCityName = WeatherConstant().getCityName();
    final box = Boxes.getFavData();
    box.add(favCityName);
    var data = box.values.toList();
    int len = data.length;
    if (kDebugMode) {
      print("Favourite city is ${data[len - 1]}");
    }
    Fluttertoast.showToast(
        msg: "${data[len - 1]} is marked as favourite City",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
