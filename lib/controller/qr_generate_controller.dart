// import 'package:ai_barcode/ai_barcode.dart';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dencode/constant/snack_messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class QrGenerateController extends GetxController {
  // CreatorController qrCreatorController = CreatorController();
  TextEditingController? qrGenerateTextEditingController;
  String initValue = "Magic QR";
  File? fileImage;
  final ImagePicker _picker = ImagePicker();
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

  addCustomImage() async {
    XFile? img = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    fileImage = File(img!.path);
    update();
  }

  saveToGallery(
      {required BuildContext context,
      required ScreenshotController screenshotController}) async {
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }
    Permission.storage.request();
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then(
      (Uint8List? image) async {
        if (image != null) {
          await ImageGallerySaver.saveImage(
            Uint8List.fromList(image),
            quality: 100,
            name: "QrImage-${DateTime.now().hashCode + Random().nextInt(9999)}",
          );

          SnackMessages.succesMessage(context, "Photo saved succesfully");
        }
      },
    );
  }

  shareQrCode({required ScreenshotController screenshotController}) async {
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }
    Permission.storage.request();
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then(
      (Uint8List? image) async {
        if (image != null) {
          final directory = await path.getApplicationDocumentsDirectory();

          final imagePath = await File('${directory.path}/image.png').create();
          await imagePath.writeAsBytes(image);
          await Share.shareFiles([imagePath.path]);
        }
      },
    );
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
