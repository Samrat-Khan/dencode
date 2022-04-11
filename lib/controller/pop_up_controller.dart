import 'dart:async';

import 'package:get/state_manager.dart';

class PopUpController extends GetxController {
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
