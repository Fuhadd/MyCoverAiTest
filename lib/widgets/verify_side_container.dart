import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_design/constants/custom_colors.dart';
import 'package:test_design/utils/enum.dart';
import 'package:test_design/utils/spacers.dart';
import 'package:test_design/widgets/custom_button.dart';

class VerifySideContainer extends StatelessWidget {
  final CarVerificationStep step;
  final void Function()? onReCaptureTap;
  final void Function()? onVerifyTap;
  const VerifySideContainer({
    super.key,
    required this.onReCaptureTap,
    required this.onVerifyTap,
    required this.step,
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
            text: TextSpan(
              style: const TextStyle(
                  // height: 1.8,
                  fontWeight: FontWeight.w900,
                  fontSize: 19,
                  color: CustomColors.whiteColor),
              children: [
                const TextSpan(
                  text: "Vehicle ",
                ),
                TextSpan(
                  text: "${getSideName(step)}  Side ",
                  style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: CustomColors.success500Color),
                ),
                const TextSpan(
                  text: "View",
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              "Confirm Vehicle ${getSideName(step).toLowerCase()}  view to move to the next Vehicle view",
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 16, color: CustomColors.whiteColor),
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: onReCaptureTap,
                    height: 45,
                    title: "Re capture",
                    titleColor: CustomColors.gray700Color,
                    color: CustomColors.whiteColor,
                  ),
                ),
                horizontalSpacer(20),
                Expanded(
                  child: CustomButton(
                    onTap: onVerifyTap,
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
