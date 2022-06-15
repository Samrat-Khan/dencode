// import 'package:ai_barcode/ai_barcode.dart';
import 'package:dencode/controller/pop_up_controller.dart';
import 'package:dencode/db/qr_data.dart';
import 'package:dencode/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowPopUp {
  qrViewPopUp({
    required String data,
    required BuildContext context,
    required double width,
    required double height,
  }) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: [
            Container(
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: 100,
                height: height * 0.3,
                child: GetX<PopUpController>(
                  init: PopUpController(),
                  initState: (init) {
                    init.controller!.showQrCode();
                  },
                  builder: (controller) {
                    return Visibility(
                      visible: controller.isVisibleQrCode.value,
                      child: Center(
                        child: QrImage(
                          data: data,
                        ),
                      ),
                      replacement: const Padding(
                        padding: EdgeInsets.all(25),
                        child: Loader(),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              data,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}
