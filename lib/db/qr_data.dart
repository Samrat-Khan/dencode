import 'package:hive/hive.dart';

part 'qr_data.g.dart';

@HiveType(typeId: 0)
class QrData {
  @HiveField(0)
  final String qrData;

  @HiveField(1)
  final DateTime dateStamp;

  @HiveField(2)
  final int uuid;
  QrData({
    required this.qrData,
    required this.dateStamp,
    required this.uuid,
  });
}
