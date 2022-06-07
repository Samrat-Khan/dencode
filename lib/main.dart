import 'package:dencode/constant/hive_box_name.dart';
import 'package:dencode/controller/qr_generate_controller.dart';
import 'package:dencode/db/qr_data.dart';
import 'package:dencode/views/home/home.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(QrGenerateController());
  await Hive.initFlutter();
  Hive.registerAdapter(QrDataAdapter());
  await Hive.openBox<QrData>(HiveBoxName.kQrDataBox);
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
//       theme: FlexThemeData.light(
//         scheme: FlexScheme.outerSpace,
//         surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
//         blendLevel: 20,
//         appBarOpacity: 0.95,
//         subThemesData: const FlexSubThemesData(
//           blendOnLevel: 20,
//           blendOnColors: false,
//           switchSchemeColor: SchemeColor.secondaryContainer,
//           checkboxSchemeColor: SchemeColor.secondaryContainer,
//           radioSchemeColor: SchemeColor.secondaryContainer,
//           inputDecoratorRadius: 25.0,
//           navigationRailLabelType: NavigationRailLabelType.selected,
//         ),
//         visualDensity: FlexColorScheme.comfortablePlatformDensity,
//         useMaterial3: true,
//         // To use the playground font, add GoogleFonts package and uncomment
//         // fontFamily: GoogleFonts.notoSans().fontFamily,
//       ),
//       darkTheme: FlexThemeData.dark(
//         scheme: FlexScheme.outerSpace,
//         surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
//         blendLevel: 15,
//         appBarStyle: FlexAppBarStyle.background,
//         appBarOpacity: 0.90,
//         subThemesData: const FlexSubThemesData(
//           blendOnLevel: 30,
//           switchSchemeColor: SchemeColor.secondaryContainer,
//           checkboxSchemeColor: SchemeColor.secondaryContainer,
//           radioSchemeColor: SchemeColor.secondaryContainer,
//           inputDecoratorRadius: 25.0,
//           navigationRailLabelType: NavigationRailLabelType.selected,
//         ),
//         visualDensity: FlexColorScheme.comfortablePlatformDensity,
//         useMaterial3: true,
//         // To use the playground font, add GoogleFonts package and uncomment
//         // fontFamily: GoogleFonts.notoSans().fontFamily,
//       ),
// // If you do not have a themeMode switch, uncomment this line
// // to let the device system mode control the theme mode:
//       themeMode: ThemeMode.system,

      debugShowCheckedModeBanner: false,
      title: "Magic QR",
      home: Home(),
    );
  }
}
