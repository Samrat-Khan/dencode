import 'package:dencode/views/qr_scanner/qr_scanner_page.dart';
import 'package:dencode/widgets/route_animation.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class FabBtn extends StatelessWidget {
  const FabBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          // MaterialPageRoute(
          //   builder: (_) => const QrScannerPage(),
          // ),
          createRoute(
            nextPage: const QrScannerPage(),
          ),
        );
      },
      child: const Icon(
        UniconsLine.qrcode_scan,
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
    );
  }
}
