// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminderLogic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderLogicAdapter extends TypeAdapter<ReminderLogic> {
  @override
  final typeId = 97;

  @override
  ReminderLogic read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderLogic(
      frequency: fields[2] as String,
      time: fields[1] as String,
      title: fields[3] as String,
      reminderIds: (fields[4] as List)?.cast<int>(),
    )..daysToRemind = (fields[0] as List)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, ReminderLogic obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.daysToRemind)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.frequency)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.reminderIds);
  }
}
