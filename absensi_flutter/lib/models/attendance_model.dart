import 'package:hive/hive.dart';
part 'attendance_model.g.dart';

@HiveType(typeId: 0)
class AttendanceModel extends HiveObject {
  @HiveField(0)
  final String date;

  @HiveField(1)
  final String time;

  @HiveField(2)
  final String location;

  @HiveField(3)
  final bool isValid;

  @HiveField(4)
  final String photoPath;

  AttendanceModel({
    required this.date,
    required this.time,
    required this.location,
    required this.isValid,
    required this.photoPath,
  });
}