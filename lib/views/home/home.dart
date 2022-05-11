import 'package:dencode/controller/navigation_controller.dart';
import 'package:dencode/views/qr_generate/qr_generate.dart';
import 'package:dencode/views/qr_result/qr_result_widget.dart';
import 'package:dencode/widgets/app_drawer.dart';
import 'package:dencode/widgets/fab_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
        init: NavigationController(),
        builder: (controller) {
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
                child: PageView(
                  // physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (i) {
                    controller.changePage(i);
                  },
                  controller: controller.pageController,
                  // children: [
                  //   SafeArea(
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 10, vertical: 10),
                  //       child: QrResultWidget(),
                  //     ),
                  //   ),
                  //   QrGenerate(),
                  // ],
                  children: controller.pages.toList(),
                ),
              ),
            ),
            floatingActionButton: const FabBtn(),
            bottomNavigationBar: SalomonBottomBar(
              currentIndex: controller.currentPage,
              onTap: (i) {
                controller.changePage(i);
              },
              items: [
                SalomonBottomBarItem(
                  icon: const Icon(Icons.qr_code_scanner_outlined),
                  title: const Text("Scan"),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.qr_code_rounded),
                  title: const Text("Generate"),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.settings),
                  title: const Text("Settings"),
                ),
              ],
            ),
          );
        });
  }
}
