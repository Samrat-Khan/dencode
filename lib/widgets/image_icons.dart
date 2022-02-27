import 'package:dencode/constant/image_path.dart';
import 'package:flutter/material.dart';

class AssetsIcons extends StatelessWidget {
  final String imagePath;
  final double size;
  const AssetsIcons({
    Key? key,
    required this.imagePath,
    this.size = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(imagePath),
      size: size,
    );
  }
}
