import 'package:ai_barcode/ai_barcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerateController extends GetxController {
  CreatorController qrCreatorController = CreatorController();
  TextEditingController? qrGenerateTextEditingController;
  String initValue = "Magic QR";
  List<int> colorCode = [
    0xff000000,
    0xff3b5998,
    0xff28aae1,
    0xffcc2127,
    0xff017fb2,
    0xfffa9c21,
    0xffe05f4f,
  ];
  int? qrDataShapeColor;
  QrEyeShape eyeShape = QrEyeShape.square;
  int? eyeColor;

  QrDataModuleShape qrDataShape = QrDataModuleShape.square;
  Color? qrDataShapesColor;

  setInputValue(String val) {
    initValue = val;
    update();
  }

  /// Qr Data Shapes
  updateQrDataShape(int i) {
    if (i == 0) {
      qrDataShape = QrDataModuleShape.circle;
    }
    if (i == 1) {
      qrDataShape = QrDataModuleShape.square;
    }
    update();
  }

  updateQrDataShapesColor(int i) {
    qrDataShapeColor = colorCode[i];
    update();
  }

  /// Qr Eye Shapes
  updateEyeDataShape(int i) {
    if (i == 0) {
      eyeShape = QrEyeShape.circle;
    }
    if (i == 1) {
      eyeShape = QrEyeShape.square;
    }
    update();
  }

  updateEyeShapesColor(int i) {
    eyeColor = colorCode[i];
    update();
  }

  @override
  void onInit() {
    super.onInit();
    qrGenerateTextEditingController = TextEditingController(
      text: initValue,
    );
    qrDataShapeColor = colorCode[0];
    eyeColor = colorCode[0];
  }

  @override
  void onClose() {
    qrGenerateTextEditingController!.dispose();
    super.onClose();
  }
}
