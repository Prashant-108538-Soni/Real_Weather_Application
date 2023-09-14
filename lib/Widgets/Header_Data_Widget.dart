import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppHeaderWidget extends StatelessWidget {

  String? location;
  String? temp;
  String? iconId;
  String datetime = DateFormat("yMMMMd").format(DateTime.now());

  AppHeaderWidget(String this.location,String this.temp,String this.iconId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Text(
                "$location",
                style: const TextStyle(fontSize: 30),
              ),
              Text(datetime,style: const TextStyle(fontSize: 16),)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Image.asset(
                  "assets/weatherImage/$iconId.png",
                  height: 60,
                  width: 60,
                ),
              ),
               Text(
                "$temp°C",
                style: const TextStyle(fontSize: 45),
              )
            ],
          ),
        ],
      ),
    );
  }
}