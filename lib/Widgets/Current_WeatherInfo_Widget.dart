import 'package:flutter/material.dart';

class CurrentWeatherInfoWidget extends StatelessWidget {

  String? wind;
  String? cloud;
  String? humidity;

   CurrentWeatherInfoWidget(String this.wind,  String this.cloud , String this.humidity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  "assets/images/windspeed (1).png",
                ),
              ),
              Text("$wind km/h"),
            ],
          ),
          Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset("assets/images/clouds.png"),
              ),
              Text("$cloud %"),
            ],
          ),
          Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset("assets/images/Humidity.png"),
              ),
              Text("$humidity %"),
            ],
          )
        ],
      ),
    );
  }
}