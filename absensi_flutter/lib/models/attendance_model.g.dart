// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceModelAdapter extends TypeAdapter<AttendanceModel> {
  @override
  final int typeId = 0;

  @override
  AttendanceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttendanceModel(
      date: fields[0] as String,
      time: fields[1] as String,
      location: fields[2] as String,
      isValid: fields[3] as bool,
      photoPath: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AttendanceModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.isValid)
      ..writeByte(4)
      ..write(obj.photoPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
