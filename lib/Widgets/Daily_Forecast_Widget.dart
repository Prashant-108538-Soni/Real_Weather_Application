import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyForecastWidget extends StatelessWidget {
  String dt;
  String iconId;
  String tempMax;
  String tempMin;
  DailyForecastWidget(this.dt, this.iconId, this.tempMax,
      this.tempMin,
      {super.key});

  String getDay(final day){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat('EEE').format(time);
    return x;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 1,
            width: 250,
            color: Colors.black,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(getDay(int.parse(dt))),
                Image.asset(
                  "assets/weatherImage/$iconId.png",
                  height: 40,
                  width: 40,
                ),
                Text("$tempMax/$tempMin \u2103"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
