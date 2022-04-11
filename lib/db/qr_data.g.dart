// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QrDataAdapter extends TypeAdapter<QrData> {
  @override
  final int typeId = 0;

  @override
  QrData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QrData(
      qrData: fields[0] as String,
      dateStamp: fields[1] as DateTime,
      uuid: fields[2] as int,
      colorCode: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, QrData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.qrData)
      ..writeByte(1)
      ..write(obj.dateStamp)
      ..writeByte(2)
      ..write(obj.uuid)
      ..writeByte(3)
      ..write(obj.colorCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QrDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
