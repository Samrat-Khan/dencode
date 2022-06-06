import 'package:dencode/controller/navigation_controller.dart';
import 'package:dencode/widgets/fab_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Magic QR",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          body: SafeArea(
            child: PageView(
              onPageChanged: (i) {
                controller.changePage(i);
              },
              controller: controller.pageController,
              children: controller.pages.toList(),
            ),
          ),
          floatingActionButton: const FabBtn(),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SalomonBottomBar(
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
          ),
        );
      },
    );
  }
}
