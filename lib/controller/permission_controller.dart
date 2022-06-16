import 'package:dencode/constant/permission_message.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isCameraPermissionGranted = false.obs;
  RxString cameraPermissionStatusMessage = ''.obs;
  Future<void> requestCameraPermission() async {
    final serviceStatus = await Permission.camera.isGranted;
    final status = await Permission.camera.request();
    if (serviceStatus) {
      isLoading.value = false;
      isCameraPermissionGranted.value = true;
    } else {
      if (status == PermissionStatus.granted) {
        isLoading.value = false;
        isCameraPermissionGranted.value = true;
        //  cameraPermissionStatusMessage.value= PermissionMessage.kPermissionGranted;
      } else if (status == PermissionStatus.denied) {
        isLoading.value = false;
        isCameraPermissionGranted.value = false;
        cameraPermissionStatusMessage.value =
            PermissionMessage.kPermissionDenied;
      } else if (status == PermissionStatus.permanentlyDenied) {
        isLoading.value = false;
        isCameraPermissionGranted.value = false;
        cameraPermissionStatusMessage.value =
            PermissionMessage.kPermissionDeniedParmanent;
      }
    }
    update();
  }

  givePermissionFromSettings() async {
    await openAppSettings();
  }
}
