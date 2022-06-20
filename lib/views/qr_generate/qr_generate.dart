import 'package:dencode/controller/qr_generate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class QrGenerate extends StatefulWidget {
  const QrGenerate({Key? key}) : super(key: key);

  @override
  State<QrGenerate> createState() => _QrGenerateState();
}

class _QrGenerateState extends State<QrGenerate> {
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<QrGenerateController>(
      init: QrGenerateController(),
      initState: (_) {},
      builder: (controller) {
        return SafeArea(
          left: false,
          right: false,
          bottom: false,
          child: Container(
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: controller.qrGenerateTextEditingController,
                    onChanged: (val) {
                      controller.setInputValue(val);
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Screenshot(
                        controller: _screenshotController,
                        child: SizedBox(
                          height: width * 0.45,
                          child: Center(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: QrImage(
                                  gapless: false,
                                  data: controller.initValue,
                                  embeddedImage: controller.fileImage == null
                                      ? null
                                      : FileImage(controller.fileImage!),
                                  embeddedImageStyle: QrEmbeddedImageStyle(
                                    size: const Size.fromRadius(10),
                                  ),
                                  dataModuleStyle: QrDataModuleStyle(
                                    dataModuleShape: controller.qrDataShape,
                                    color: Color(controller.qrDataShapeColor!),
                                  ),
                                  eyeStyle: QrEyeStyle(
                                    eyeShape: controller.eyeShape,
                                    color: Color(controller.eyeColor!),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.share,
                                size: 25,
                              ),
                              onPressed: () async {
                                await controller.shareQrCode(
                                    screenshotController:
                                        _screenshotController);
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.save_alt_rounded,
                                size: 25,
                              ),
                              onPressed: () async {
                                await controller.saveToGallery(
                                  context: context,
                                  screenshotController: _screenshotController,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  TextButton.icon(
                    onPressed: () async {
                      await controller.addCustomImage();
                    },
                    label: Text(
                      "Add Image",
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                    icon: const Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "QR Inside Styling",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTxtBtn(
                        title: "Square",
                        onTap: () {
                          controller.updateQrDataShape(1);
                        },
                      ),
                      const SizedBox(width: 20),
                      CustomTxtBtn(
                        title: "Circle",
                        onTap: () {
                          controller.updateQrDataShape(0);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ListOfColorWidgets(
                    itemCount: controller.colorCode.length,
                    colorCodes: controller.colorCode,
                    onTap: (int i) {
                      controller.updateQrDataShapesColor(i);
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "QR Corner Styling",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTxtBtn(
                        title: "Square",
                        onTap: () {
                          controller.updateEyeDataShape(1);
                        },
                      ),
                      const SizedBox(width: 20),
                      CustomTxtBtn(
                        title: "Circle",
                        onTap: () {
                          controller.updateEyeDataShape(0);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ListOfColorWidgets(
                    itemCount: controller.colorCode.length,
                    colorCodes: controller.colorCode,
                    onTap: (int i) {
                      controller.updateEyeShapesColor(i);
                    },
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ListOfColorWidgets extends StatelessWidget {
  final int itemCount;
  final List<int> colorCodes;
  final Function(int) onTap;
  const ListOfColorWidgets({
    Key? key,
    required this.itemCount,
    required this.colorCodes,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: colorCodes.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: () => onTap(i),
              child: CircleAvatar(
                backgroundColor: Color(
                  colorCodes[i],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomTxtBtn extends StatelessWidget {
  final Function onTap;
  final String title;
  const CustomTxtBtn({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
