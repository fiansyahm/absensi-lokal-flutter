import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import '../models/attendance_model.dart';
import '../services/location_service.dart';
import '../services/storage_service.dart';
import 'history_screen.dart';

class AttendanceScreen extends StatefulWidget {
  final String userName;
  const AttendanceScreen({super.key, required this.userName});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final LocationService _locationService = LocationService();
  final StorageService _storageService = StorageService();
  String? _currentLocation;
  bool _isInRange = false;
  File? _selfieImage;
  bool _hasCheckedInToday = false;

  @override
  void initState() {
    super.initState();
    _checkLocation();
    _checkTodayAttendance();
  }

  Future<void> _checkLocation() async {
    final position = await _locationService.getCurrentLocation();
    if (position != null) {
      final distance = _locationService.calculateDistance(
        position.latitude,
        position.longitude,
        -6.200000,
        106.816666,
      );
      setState(() {
        _currentLocation = 'Lat: ${position.latitude}, Long: ${position.longitude}';
        _isInRange = distance <= 100;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mendapatkan lokasi. Harap aktifkan layanan lokasi.')),
      );
    }
  }

  Future<void> _checkTodayAttendance() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final attendance = await _storageService.getAttendance();
    setState(() {
      _hasCheckedInToday = attendance.any((a) => a.date == today);
    });
  }

  Future<void> _takeSelfie() async {
    final cameraStatus = await Permission.camera.request();
    if (!cameraStatus.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Izin kamera ditolak. Harap aktifkan di pengaturan.')),
      );
      await openAppSettings();
      return;
    }

    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
      );
      if (pickedFile != null) {
        setState(() {
          _selfieImage = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak ada gambar yang diambil.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan saat mengakses kamera: $e')),
      );
    }
  }

  Future<void> _checkIn() async {
    if (_isInRange && _selfieImage != null) {
      final attendance = AttendanceModel(
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        time: DateFormat('HH:mm').format(DateTime.now()),
        location: _currentLocation ?? 'Tidak diketahui',
        isValid: _isInRange,
        photoPath: _selfieImage!.path,
      );
      await _storageService.saveAttendance(attendance);
      setState(() {
        _hasCheckedInToday = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Absensi berhasil disimpan.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan ambil selfie dan pastikan lokasi valid.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absensi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HistoryScreen()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selamat datang, ${widget.userName}'),
            Text('Tanggal: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}'),
            Text('Lokasi: ${_currentLocation ?? 'Sedang mengecek...'}'),
            Text('Status: ${_hasCheckedInToday ? 'Sudah absen hari ini' : 'Belum absen'}'),
            const SizedBox(height: 20),
            if (_selfieImage != null) Image.file(_selfieImage!, height: 100),
            ElevatedButton(
              onPressed: _takeSelfie,
              child: const Text('Ambil Selfie'),
            ),
            ElevatedButton(
              onPressed: (_isInRange && _selfieImage != null && !_hasCheckedInToday) ? _checkIn : null,
              child: const Text('Absen Sekarang'),
            ),
          ],
        ),
      ),
    );
  }
}
