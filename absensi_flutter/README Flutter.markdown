# Aplikasi Absensi

Aplikasi mobile berbasis Flutter untuk mencatat kehadiran dengan validasi lokasi dan pengambilan foto selfie.

## Cara Menjalankan

1. **Prasyarat**:
   - Instal [Flutter](https://flutter.dev/docs/get-started/install) (disarankan versi 3.29.3 atau lebih tinggi).
   - Instal [Android Studio](https://developer.android.com/studio) dengan Android SDK 35.
   - Siapkan emulator Android (API 35, dengan dukungan kamera) atau perangkat Android fisik dengan USB debugging diaktifkan.

2. **Kloning Repositori**:
   ```bash
   git clone <url-repositori>
   cd absensi_flutter
   ```

3. **Instal Dependensi**:
   ```bash
   flutter pub get
   ```

4. **Generate Adapter Hive**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. **Konfigurasi Emulator Android**:
   - Di Android Studio, buat atau edit emulator (misalnya, Pixel 9, API 35).
   - Aktifkan kamera: Atur "Front Camera" dan "Back Camera" ke "Webcam0".
   - Atur lokasi tiruan: Di Extended Controls > Location pada emulator, gunakan koordinat seperti `-6.200000, 106.816666`.

6. **Jalankan Aplikasi**:
   - Mode debug:
     ```bash
     flutter run -d <id-emulator-atau-perangkat>
     ```
   - Buat APK rilis:
     ```bash
     flutter build apk --release
     flutter install -d <id-emulator-atau-perangkat>
     ```

7. **Izinkan Izin**:
   - Izinkan akses kamera dan lokasi saat diminta.
   - Uji fitur "Ambil Selfie" dan "Check In".

## Plugin yang Digunakan

Aplikasi ini menggunakan plugin Flutter berikut:
- `geolocator: ^12.0.0` - Untuk mengakses lokasi perangkat dan memvalidasi jarak.
- `image_picker: ^1.1.2` - Untuk mengambil foto selfie menggunakan kamera perangkat.
- `permission_handler: ^11.3.1` - Untuk meminta izin kamera dan lokasi.
- `path_provider: ^2.1.5` - Untuk mengakses jalur penyimpanan file.
- `hive: ^2.2.3` dan `hive_flutter: ^1.1.0` - Untuk penyimpanan lokal data absensi.
- `intl: ^0.17.0` - Untuk memformat tanggal dan waktu.
- `hive_generator: ^2.0.1` dan `build_runner: ^2.4.6` - Untuk menghasilkan adapter Hive.

## Catatan Khusus

- **Android SDK**: Aplikasi memerlukan Android SDK 35 (ditetapkan di `android/app/build.gradle.kts`) untuk mendukung dependensi plugin.
- **Versi NDK**: Menggunakan NDK versi 27.0.12077973 untuk kompatibilitas dengan plugin.
- **Dukungan Kamera**: Pastikan emulator memiliki kamera virtual aktif ("Webcam0") atau gunakan perangkat fisik dengan kamera depan.
- **Pengujian Lokasi**: Atur lokasi tiruan di emulator untuk menguji validasi lokasi (misalnya, dalam radius 100 meter dari `-6.200000, 106.816666`).
- **Masalah Build**: Jika `build_runner` gagal, jalankan dengan `--verbose` untuk mendiagnosis:
  ```bash
  dart run build_runner build --delete-conflicting-outputs --verbose
  ```
- **Izin**: Aplikasi memerlukan izin kamera dan lokasi, yang dideklarasikan di `android/app/src/main/AndroidManifest.xml`.

Untuk masalah atau kontribusi, silakan buka isu di repositori.