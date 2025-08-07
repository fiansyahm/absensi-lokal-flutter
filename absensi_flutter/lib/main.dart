import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/attendance_model.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AttendanceModelAdapter());
  await Hive.openBox<AttendanceModel>('attendance');
  runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Absensi Lokasi ',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}