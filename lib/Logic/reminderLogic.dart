import 'package:hive/hive.dart';

part 'reminderLogic.g.dart';

@HiveType(typeId: 97)
class ReminderLogic {
  @HiveField(0)
  List<String> daysToRemind = [];
  @HiveField(1)
  String time;
  @HiveField(2)
  String frequency;
  @HiveField(3)
  String title;
  @HiveField(4)
  List<int> reminderIds;

  ReminderLogic({this.frequency, this.time, this.title, this.reminderIds});
}
