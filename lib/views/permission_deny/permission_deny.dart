import 'package:dencode/constant/image_path.dart';
import 'package:dencode/constant/permission_message.dart';
import 'package:dencode/controller/permission_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PermissionDenyScreen extends StatefulWidget {
  final Size size;
  final String message;
  final PermissionController controller;
  final Function(bool) callBack;
  const PermissionDenyScreen({
    Key? key,
    required this.message,
    required this.size,
    required this.controller,
    required this.callBack,
  }) : super(key: key);

  @override
  State<PermissionDenyScreen> createState() => _PermissionDenyScreenState();
}

class _PermissionDenyScreenState extends State<PermissionDenyScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        widget.callBack(true);
        // await scannerController.start();
        break;
      case AppLifecycleState.inactive:
        // await scannerController.stop();
        break;
      case AppLifecycleState.paused:
        // await scannerController.stop();
        break;
      case AppLifecycleState.detached:
        // await scannerController.stop();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: widget.size.width,
        height: widget.size.height,
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
                  width: widget.size.width * 0.25,
                  height: widget.size.width * 0.25,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagePath.kNoPermissionBg),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  widget.message,
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
                    widget.controller.cameraPermissionStatusMessage ==
                            PermissionMessage.kPermissionDeniedParmanent
                        ? widget.controller.givePermissionFromSettings()
                        : widget.controller.requestCameraPermission();
                  },
                  child: Text(
                    // ignore: unrelated_type_equality_checks
                    widget.controller.cameraPermissionStatusMessage ==
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
