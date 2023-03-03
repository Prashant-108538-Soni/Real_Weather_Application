import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyWidget extends StatelessWidget {
  String? temp;
  String? iconId;
  String? dt;
  int? index;

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    if (kDebugMode) {
      print("From getTime$x");
    }
    return x;
  }

  HourlyWidget(
      String this.temp, String this.iconId, String this.dt, int this.index,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: index == 0 ? Colors.deepPurple[400] : Colors.deepPurple[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            getTime(int.parse(dt!)),
          ),
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(10),
            child:Image.asset("assets/weatherImage/$iconId.png"),
          ),
          Text( "$temp \u2103"),
        ],
      ),
    );
  }
}
