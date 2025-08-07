import 'package:hive/hive.dart';
import '../models/attendance_model.dart';

class StorageService {
  final _box = Hive.box<AttendanceModel>('attendance');

  Future<void> saveAttendance(AttendanceModel attendance) async {
    await _box.add(attendance);
  }

  Future<List<AttendanceModel>> getAttendance() async {
    return _box.values.toList();
  }
}