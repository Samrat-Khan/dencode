import 'dart:async';

import 'package:get/get.dart';

class PopUpController extends GetxController {
  @override
  void onClose() {
    isVisibleQrCode.value = false;
    super.onClose();
  }

  RxBool isVisibleQrCode = false.obs;
  showQrCode() {
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        isVisibleQrCode.value = true;
      },
    );
  }
}
