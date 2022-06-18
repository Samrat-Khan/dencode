import 'package:dencode/constant/permission_message.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  bool isLoading = true;
  bool isCameraPermissionGranted = false;
  String cameraPermissionStatusMessage = '';
  Future<void> requestCameraPermission() async {
    final serviceStatus = await Permission.camera.isGranted;

    if (serviceStatus) {
      isLoading = false;
      isCameraPermissionGranted = true;
    } else {
      final status = await Permission.camera.request();
      if (status.isGranted) {
        isLoading = false;
        isCameraPermissionGranted = true;
        //  cameraPermissionStatusMessage.value= PermissionMessage.kPermissionGranted;
      }
      if (status == PermissionStatus.denied) {
        isLoading = false;
        isCameraPermissionGranted = false;
        cameraPermissionStatusMessage = PermissionMessage.kPermissionDenied;
      }
      if (status == PermissionStatus.permanentlyDenied) {
        isLoading = false;
        isCameraPermissionGranted = false;
        cameraPermissionStatusMessage =
            PermissionMessage.kPermissionDeniedParmanent;
      }
    }
    update();
  }

  givePermissionFromSettings() async {
    await openAppSettings();
  }

  @override
  void onInit() {
    requestCameraPermission();
    super.onInit();
  }
}
