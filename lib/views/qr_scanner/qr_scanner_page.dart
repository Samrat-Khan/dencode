import 'dart:math';

import 'package:dencode/constant/color_codes.dart';
import 'package:dencode/constant/image_path.dart';
import 'package:dencode/constant/permission_message.dart';
import 'package:dencode/controller/db_controller.dart';
import 'package:dencode/controller/permission_controller.dart';
import 'package:dencode/db/qr_data.dart';
import 'package:dencode/views/home/home.dart';
import 'package:dencode/widgets/loader.dart';
import 'package:dencode/widgets/route_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({Key? key}) : super(key: key);

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage>
    with WidgetsBindingObserver {
  // late ScannerController _scannerController;
  final DbController dbController = DbController();
  Random ran = Random();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // _scannerController = ScannerController(scannerResult: (result) {
    //   dbController.addQrResult(
    //     data: QrData(
    //       qrData: result,
    //       dateStamp: DateTime.now(),
    //       uuid: DateTime.now().microsecondsSinceEpoch,
    //       colorCode: ColorCodes
    //           .kColorCodes[ran.nextInt(ColorCodes.kColorCodes.length)],
    //     ),
    //   );
    //   _resultCallback(result);
    // }, scannerViewCreated: () {
    //   TargetPlatform platform = Theme.of(context).platform;
    //   if (TargetPlatform.iOS == platform) {
    //     Future.delayed(const Duration(seconds: 2), () {
    //       _scannerController.startCamera();
    //       _scannerController.startCameraPreview();
    //     });
    //   } else {
    //     _scannerController.startCamera();
    //     _scannerController.startCameraPreview();
    //   }
    // });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // _scannerController.stopCameraPreview();
    // _scannerController.stopCamera();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  _resultCallback(String result) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, state) {
            return SimpleDialog(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              children: [
                SelectableText(
                  result,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        createRoute(
                          nextPage: Home(),
                        ),
                      );
                    },
                    child: Text(
                      "Done",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<PermissionController>(
        init: PermissionController(),
        initState: (init) {
          init.controller!.requestCameraPermission();
        },
        builder: (controller) {
          return controller.isLoading.value
              ? const Center(
                  child: Loader(),
                )
              : !controller.isCameraPermissionGranted.value
                  ? retryPermissionUi(
                      message: controller.cameraPermissionStatusMessage.value,
                      size: MediaQuery.of(context).size,
                      controller: controller,
                    )
                  : MobileScanner(
                      onDetect: (code, args) {},
                    );
        },
      ),
    );
  }

  retryPermissionUi(
      {required String message,
      required Size size,
      required PermissionController controller}) {
    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(height: 60),
                Container(
                  width: size.width * 0.25,
                  height: size.width * 0.25,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagePath.kNoPermissionBg),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  message,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // ignore: unrelated_type_equality_checks
                    controller.cameraPermissionStatusMessage ==
                            PermissionMessage.kPermissionDeniedParmanent
                        ? controller.givePermissionFromSettings()
                        : controller.requestCameraPermission();
                  },
                  child: Text(
                    // ignore: unrelated_type_equality_checks
                    controller.cameraPermissionStatusMessage ==
                            PermissionMessage.kPermissionDeniedParmanent
                        ? 'Open Settings'
                        : "Try again",
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
