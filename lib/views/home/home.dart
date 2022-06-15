import 'package:dencode/controller/navigation_controller.dart';
import 'package:dencode/widgets/fab_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) {
        return Scaffold(
          // extendBody: true,
          // extendBodyBehindAppBar: true,
          // appBar: AppBar(
          //   elevation: 0,
          //   backgroundColor: Colors.transparent,
          //   title: Text(
          //     "Magic QR",
          //     style: GoogleFonts.poppins(
          //       color: Colors.black,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 22,
          //     ),
          //   ),
          // ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (i) {
              controller.changePage(i);
            },
            controller: controller.pageController,
            children: controller.pages.toList(),
          ),
          floatingActionButton: Visibility(
            visible: controller.currentPage != 1 &&
                MediaQuery.of(context).viewInsets.bottom == 0,
            child: const FabBtn(),
          ),
          bottomNavigationBar: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Card(
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
