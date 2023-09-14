import 'package:hive_flutter/hive_flutter.dart';

part 'History_model.g.dart';

@HiveType(typeId: 0)
class HistoryModel extends HiveObject {
  @HiveField(0)
  late String cityName;
  @HiveField(1)
  late String minTemp;
  @HiveField(2)
  late String maxTemp;
  @HiveField(3)
  late String iconId;
  @HiveField(4)
  late String cDate;
  @HiveField(5)
  late String cTime;

  HistoryModel(this.cityName, this.minTemp, this.maxTemp, this.iconId,
      this.cDate, this.cTime);
}
