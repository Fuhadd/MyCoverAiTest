import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_design/constants/custom_colors.dart';
import 'package:test_design/constants/custom_string.dart';
import 'package:test_design/screens/vehicle_verification_screen.dart';
import 'package:test_design/utils/spacers.dart';

class VerifySideContainer extends StatelessWidget {
  const VerifySideContainer({
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
          const Expanded(flex: 2, child: SizedBox()),
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
          const Expanded(child: SizedBox()),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              "Confirm Vehicle side view to move to the next Vehicle view",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: CustomColors.whiteColor),
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                const Expanded(
                  child: CustomButton(
                    height: 45,
                    title: "Re capture",
                    titleColor: CustomColors.gray700Color,
                    color: CustomColors.whiteColor,
                  ),
                ),
                horizontalSpacer(20),
                const Expanded(
                  child: CustomButton(
                    height: 45,
                    title: "Verify",
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
