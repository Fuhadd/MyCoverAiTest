import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_design/constants/custom_colors.dart';

class SelectedImageContainer extends StatelessWidget {
  const SelectedImageContainer({
    super.key,
    required this.imageFile,
    this.height,
    this.width,
  });

  final Uint8List? imageFile;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'imagePreview',
      child: DottedBorder(
        strokeWidth: 3,
        padding: EdgeInsets.zero,
        borderPadding: EdgeInsets.zero,
        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        dashPattern: const [15, 13],
        child: Container(
          height: height ?? 1.sh * 0.7,
          width: width ?? 1.sw * 0.6,
          decoration: BoxDecoration(
              border: Border.all(color: CustomColors.whiteColor, width: 5),
              borderRadius: BorderRadius.circular(8)),
          child: Image.memory(
            imageFile!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
