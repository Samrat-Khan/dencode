import 'package:dencode/views/qr_generate/qr_generate.dart';
import 'package:dencode/views/qr_result/qr_result_widget.dart';
import 'package:dencode/views/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  List<Widget> pages = [
    QrResultWidget(),
    QrGenerate(),
    const Settings(),
  ];

  PageController pageController =
      PageController(initialPage: 1, keepPage: true);
  int currentPage = 1;
  changePage(int index) {
    currentPage = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 100), curve: Curves.easeIn);

    update();
  }

  @override
  void onClose() {
    pageController.dispose();

    super.onClose();
  }
}
