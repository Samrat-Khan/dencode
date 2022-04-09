import 'package:ai_barcode/ai_barcode.dart';
import 'package:dencode/constant/image_path.dart';
import 'package:dencode/controller/pop_up_controller.dart';
import 'package:dencode/widgets/image_icons.dart';
import 'package:dencode/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowPopUp {
  qrViewPopUp({
    required String data,
    required BuildContext context,
    required double width,
    required double height,
    required CreatorController creatorController,
  }) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
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
                      child: PlatformAiBarcodeCreatorWidget(
                        creatorController: creatorController,
                        initialValue: 'Samrat',
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
          ],
        );
      },
    );
  }
}
