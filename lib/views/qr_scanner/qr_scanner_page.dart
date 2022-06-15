import 'dart:math';

import 'package:dencode/constant/color_codes.dart';
import 'package:dencode/constant/image_path.dart';
import 'package:dencode/constant/permission_message.dart';
import 'package:dencode/controller/db_controller.dart';
import 'package:dencode/controller/permission_controller.dart';
import 'package:dencode/db/qr_data.dart';
import 'package:dencode/widgets/loader.dart';
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
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  // late ScannerController _scannerController;
  final DbController dbController = DbController();
  late final AnimationController _animationController;
  late MobileScannerController scannerController;
  bool _flashOn = false;
  bool _flipCamera = false;
  Random ran = Random();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    scannerController = MobileScannerController(
      torchEnabled: _flashOn,
      formats: [
        BarcodeFormat.all,
      ],
    );
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  stopCamera() async {
    await scannerController.stop();
    scannerController.dispose();
    Navigator.of(context).pop();
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

  swicthFlash() {
    setState(() {
      _flashOn = !_flashOn;
    });
    scannerController.toggleTorch();
  }

  swicthCamera() {
    setState(() {
      _flipCamera = !_flipCamera;
    });
    scannerController.switchCamera();
  }

  _resultCallback(String result) {
    dbController.addQrResult(
      data: QrData(
        qrData: result,
        dateStamp: DateTime.now(),
        uuid: DateTime.now().microsecondsSinceEpoch,
        colorCode:
            ColorCodes.kColorCodes[ran.nextInt(ColorCodes.kColorCodes.length)],
      ),
    );
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
                    onPressed: () async {
                      await stopCamera();
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
          if (controller.isLoading.value) {
            return const Center(
              child: Loader(),
            );
          } else {
            if (!controller.isCameraPermissionGranted.value) {
              return retryPermissionUi(
                message: controller.cameraPermissionStatusMessage.value,
                size: MediaQuery.of(context).size,
                controller: controller,
              );
            } else {
              return SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.width * 0.7,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: MobileScanner(
                              controller: scannerController,
                              onDetect: (code, args) {
                                _resultCallback(code.rawValue!);
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: swicthFlash,
                              child: AnimatedSwitcher(
                                duration: const Duration(
                                  milliseconds: 100,
                                ),
                                child: _flashOn
                                    ? const Icon(
                                        Icons.flash_on_outlined,
                                        color: Color(0xffffc107),
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.flash_off_rounded,
                                        size: 30,
                                      ),
                              ),
                            ),
                            InkWell(
                              onTap: swicthCamera,
                              child: AnimatedSwitcher(
                                duration: const Duration(
                                  milliseconds: 100,
                                ),
                                child: _flipCamera
                                    ? const Icon(
                                        Icons.camera_front_rounded,
                                        color: Color(0xffffc107),
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.photo_camera_back_rounded,
                                        size: 30,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
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
