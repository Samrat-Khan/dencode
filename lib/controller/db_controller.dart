import 'package:dencode/constant/hive_box_name.dart';
import 'package:dencode/db/qr_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DbController {
  final qrResult = Hive.box<QrData>(HiveBoxName.kQrDataBox);

  addQrResult({required QrData data}) {
    qrResult.add(data);
  }

  removeQrResult({required int index}) {
    qrResult.deleteAt(index);
  }
}
