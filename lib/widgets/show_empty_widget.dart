import 'package:dencode/constant/image_path.dart';
import 'package:flutter/material.dart';

class ShowEmptyWidget extends StatelessWidget {
  const ShowEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagePath.kNoData),
        ),
      ),
    );
  }
}
