import 'package:flutter/material.dart';
import 'dart:io';
import '../models/attendance_model.dart';
import '../services/storage_service.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StorageService storageService = StorageService();

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance History')),
      body: FutureBuilder<List<AttendanceModel>>(
        future: storageService.getAttendance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final attendanceList = snapshot.data!;
          return ListView.builder(
            itemCount: attendanceList.length,
            itemBuilder: (context, index) {
              final attendance = attendanceList[index];
              return ListTile(
                leading: attendance.photoPath.isNotEmpty
                    ? Image.file(File(attendance.photoPath), width: 50, height: 50)
                    : const Icon(Icons.image),
                title: Text('${attendance.date} ${attendance.time}'),
                subtitle: Text('Location: ${attendance.location}\nValid: ${attendance.isValid}'),
              );
            },
          );
        },
      ),
    );
  }
}