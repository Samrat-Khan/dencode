import 'package:dencode/views/qr_result_widget.dart';
import 'package:dencode/widgets/app_drawer.dart';
import 'package:dencode/widgets/fab_btn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SliderDrawer(
          appBar: SliderAppBar(
            appBarPadding: const EdgeInsets.only(top: 0),
            title: Text(
              "Magic QR",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          key: _key,
          sliderOpenSize: 179,
          slider: const AppDrawer(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: QrResultWidget(),
            ),
          ),
        ),
      ),
      floatingActionButton: const FabBtn(),
    );
  }
}
