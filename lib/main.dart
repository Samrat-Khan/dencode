import 'package:dencode/constant/hive_box_name.dart';
import 'package:dencode/controller/navigation_controller.dart';
import 'package:dencode/controller/qr_generate_controller.dart';
import 'package:dencode/db/qr_data.dart';
import 'package:dencode/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(QrDataAdapter());
  await Hive.openBox<QrData>(HiveBoxName.kQrDataBox);
  Get.put(QrGenerateController());
  Get.put(NavigationController());
  Future.delayed(const Duration(seconds: 2));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ],
    );
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Magic QR",
      home: Home(),
    );
  }
}
