import 'package:flutter/material.dart';
import 'package:test_design/constants/custom_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color? color;
  final double height;
  final Color? titleColor;
  final void Function()? onTap;
  final FontWeight? fontWeight;
  final double? fontSize;
  const CustomButton({
    super.key,
    required this.title,
    this.color = CustomColors.greenColor,
    this.height = 50,
    this.titleColor = CustomColors.whiteColor,
    this.onTap,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 17,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: titleColor,
            ),
          ),
        ),
      ),
    );
  }
}
