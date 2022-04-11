import 'package:ai_barcode/ai_barcode.dart';
import 'package:dencode/constant/hive_box_name.dart';
import 'package:dencode/constant/image_path.dart';
import 'package:dencode/controller/date_time.dart';
import 'package:dencode/controller/db_controller.dart';
import 'package:dencode/db/qr_data.dart';
import 'package:dencode/widgets/image_icons.dart';
import 'package:dencode/widgets/show_empty_widget.dart';
import 'package:dencode/widgets/show_qr_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class QrResultWidget extends StatelessWidget {
  QrResultWidget({
    Key? key,
  }) : super(key: key);

  final DateTimeController date = DateTimeController();
  final ShowPopUp showPopUp = ShowPopUp();
  final CreatorController creatorController = CreatorController();
  final DbController dbController = DbController();
  final qrResult = Hive.box<QrData>(HiveBoxName.kQrDataBox);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
      valueListenable: qrResult.listenable(),
      builder: (context, Box<QrData> data, _) {
        return data.isEmpty
            ? const ShowEmptyWidget()
            : ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (ctx, i) {
                  final result = qrResult.getAt(i);
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  showPopUp.qrViewPopUp(
                                    data: result!.qrData,
                                    context: context,
                                    width: width,
                                    height: height,
                                    creatorController: creatorController,
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(ImagePath.kQrCode),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              SizedBox(
                                width: width * 0.6,
                                child: Text(
                                  result!.qrData,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  dbController.removeQrResult(index: i);
                                },
                                icon: const AssetsIcons(
                                    imagePath: ImagePath.kDelete),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 0.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                date.fullDate(
                                  date: result.dateStamp,
                                ),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                date.fullTime(
                                  time: result.dateStamp,
                                ),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
