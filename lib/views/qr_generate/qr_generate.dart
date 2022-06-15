import 'package:dencode/controller/qr_generate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerate extends StatelessWidget {
  const QrGenerate({Key? key}) : super(key: key);
  @override
  // final controller = Get.find<QrGenerateController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GetBuilder<QrGenerateController>(
        init: QrGenerateController(),
        initState: (_) {},
        builder: (controller) {
          return Container(
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
                  SizedBox(
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
                  const SizedBox(height: 20),
                  Text(
                    "QR Data Shapes",
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
                          controller.updateQrDataShape(0);
                        },
                      ),
                      const SizedBox(width: 20),
                      CustomTxtBtn(
                        title: "Circle",
                        onTap: () {
                          controller.updateQrDataShape(1);
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
                    "QR Corner Shapes",
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
          );
        },
      ),
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
