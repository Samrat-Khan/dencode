import 'package:ai_barcode/ai_barcode.dart';
import 'package:dencode/controller/qr_generate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrGenerate extends GetView<QrGenerateController> {
  QrGenerate({Key? key}) : super(key: key);
  @override
  final controller = Get.put(QrGenerateController());
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: controller.qrGenerateTextEditingController,
              onChanged: (val) {
                controller.setInputValue(val);
              },
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: width,
              height: width * 0.4,
              child: PlatformAiBarcodeCreatorWidget(
                creatorController: controller.qrCreatorController,
                initialValue: controller.initValue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
