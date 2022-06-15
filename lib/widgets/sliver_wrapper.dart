import 'package:dencode/controller/date_time.dart';
import 'package:dencode/controller/db_controller.dart';
import 'package:dencode/db/qr_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class SliverBody extends StatelessWidget {
  const SliverBody({
    Key? key,
    required this.qrResult,
    required this.width,
    required this.dbController,
    required this.date,
    required this.sliverBody,
  }) : super(key: key);

  final Box<QrData> qrResult;
  final double width;
  final DbController dbController;
  final DateTimeController date;
  final Widget sliverBody;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Magic QR",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: sliverBody,
        ),
      ],
    );
  }
}
