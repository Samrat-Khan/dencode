import 'package:dencode/constant/image_path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const DrawerHeader(
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(ImagePath.kAppIcon),
            ),
          ),
          // const SizedBox(
          //   height: 30,
          // ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Thank you for using Magic QR 😊",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            "Made with Flutter 💖",
            style: GoogleFonts.poppins(),
            textAlign: TextAlign.center,
          ),
          Text(
            "V0.0.1 (beta)",
            style: GoogleFonts.poppins(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
