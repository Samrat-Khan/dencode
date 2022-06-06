import 'package:ai_barcode/ai_barcode.dart';
import 'package:dencode/controller/qr_generate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerate extends StatelessWidget {
  const QrGenerate({Key? key}) : super(key: key);
  @override
  // final controller = Get.find<QrGenerateController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<QrGenerateController>(
        init: QrGenerateController(),
        initState: (_) {},
        builder: (controller) {
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
                    child: Center(
                      child: QrImage(
                        gapless: false,
                        data: controller.initValue,
                        dataModuleStyle: const QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.circle,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
