import 'package:dencode/constant/image_path.dart';
import 'package:dencode/widgets/image_icons.dart';
import 'package:flutter/material.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';
import 'package:unicons/unicons.dart';

class FabBtn extends StatelessWidget {
  const FabBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDialFabWidget(
      secondaryIconsList: const [
        UniconsLine.images,
        UniconsLine.qrcode_scan,
      ],
      secondaryIconsOnPress: [
        () {},
        () {},
      ],
      secondaryIconsText: const [
        '',
        '',
      ],
    );
  }
}
