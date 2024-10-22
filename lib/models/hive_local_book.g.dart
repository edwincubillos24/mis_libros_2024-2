// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_local_book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLocalBookAdapter extends TypeAdapter<HiveLocalBook> {
  @override
  final int typeId = 0;

  @override
  HiveLocalBook read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLocalBook()
      ..title = fields[0] as String?
      ..bookImage = fields[1] as String?
      ..author = fields[2] as String?
      ..publisher = fields[3] as String?
      ..description = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, HiveLocalBook obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.bookImage)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.publisher)
      ..writeByte(4)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLocalBookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
