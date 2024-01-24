import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_design/constants/custom_colors.dart';
import 'package:test_design/constants/custom_string.dart';
import 'package:test_design/screens/car_inspection/vehicle_verification_screen.dart';
import 'package:test_design/utils/spacers.dart';

class CaptureSideContainer extends StatelessWidget {
  final void Function()? onTap;
  const CaptureSideContainer({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw * 0.14,
      color: CustomColors.blackColor.withOpacity(0.7),
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: SvgPicture.asset(
            ConstantString.whiteCaptureIcon,
            height: 210,
            // fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
