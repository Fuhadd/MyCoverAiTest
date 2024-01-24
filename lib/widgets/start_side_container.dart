import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_design/constants/custom_colors.dart';
import 'package:test_design/constants/custom_string.dart';
import 'package:test_design/screens/car_inspection/vehicle_verification_screen.dart';
import 'package:test_design/utils/spacers.dart';

class StartSideContainer extends StatelessWidget {
  const StartSideContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw * 0.4,
      color: CustomColors.transGray100Color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                  // height: 1.8,
                  fontWeight: FontWeight.w900,
                  fontSize: 19,
                  color: CustomColors.whiteColor),
              children: [
                TextSpan(
                  text: "Vehicle ",
                ),
                TextSpan(
                  text: "Left Side ",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: CustomColors.success500Color),
                ),
                TextSpan(
                  text: "View",
                ),
              ],
            ),
          ),
          verticalSpacer(10),
          const Text(
            "Take Vehicle left view",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: CustomColors.whiteColor),
          ),
          const Expanded(child: SizedBox()),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(
              ConstantString.carLeftViewNoBg,
              fit: BoxFit.cover,
            ),
          ),
          verticalSpacer(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                const Expanded(
                  child: CustomButton(
                    height: 45,
                    title: "Go back",
                    titleColor: CustomColors.gray700Color,
                    color: CustomColors.whiteColor,
                  ),
                ),
                horizontalSpacer(20),
                const Expanded(
                  child: CustomButton(
                    height: 45,
                    title: "Start",
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
