import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_design/constants/custom_colors.dart';
import 'package:test_design/constants/custom_string.dart';

class CaptureSideContainer extends StatelessWidget {
  final void Function()? onTap;
  final bool isLoading;
  const CaptureSideContainer({
    super.key,
    required this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw * 0.15,
      color: CustomColors.blackColor.withOpacity(0.7),
      child: Center(
        child: GestureDetector(
          onTap: isLoading ? null : onTap,
          child: SvgPicture.asset(
            isLoading
                ? ConstantString.greenCaptureIcon
                : ConstantString.whiteCaptureIcon,
            height: 210,
          ),
        ),
      ),
    );
  }
}
