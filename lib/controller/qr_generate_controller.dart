import 'package:ai_barcode/ai_barcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class QrGenerateController extends GetxController {
  TextEditingController qrGenerateTextEditingController = TextEditingController(
    text: "Type here",
  );
  String initValue = "Type Here";
  CreatorController qrCreatorController = CreatorController();
  setInputValue(String val) {
    initValue = val;
    update();
  }


  @override
  void onClose() {
    qrGenerateTextEditingController.dispose();
    super.onClose();
  }
}
