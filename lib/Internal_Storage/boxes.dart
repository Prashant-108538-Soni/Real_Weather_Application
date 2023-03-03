import 'package:hive_flutter/hive_flutter.dart';

import '../Model/History_model.dart';

class Boxes {
  static Box<HistoryModel> getData() => Hive.box<HistoryModel>("history");
  static Box<String> getFavData() => Hive.box<String>("fav");
}
