import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_design/constants/custom_colors.dart';
import 'package:test_design/utils/enum.dart';
import 'package:test_design/utils/spacers.dart';
import 'package:test_design/widgets/custom_button.dart';

class StartSideContainer extends StatelessWidget {
  final CarVerificationStep step;
  final void Function() onTap;
  const StartSideContainer({
    super.key,
    required this.step,
    required this.onTap,
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
            text: TextSpan(
              style: const TextStyle(
                  // height: 1.8,
                  fontWeight: FontWeight.w700,
                  fontSize: 19,
                  color: CustomColors.whiteColor),
              children: [
                const TextSpan(
                  text: "Vehicle ",
                ),
                TextSpan(
                  text: "${getSideName(step)} Side ",
                  style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: CustomColors.success500Color),
                ),
                const TextSpan(
                  text: "View",
                ),
              ],
            ),
          ),
          verticalSpacer(10),
          Text(
            "Take Vehicle ${getSideName(step)} View",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: CustomColors.whiteColor),
          ),
          const Expanded(child: SizedBox()),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(
              getSideImage(step),
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
                    fontSize: 16,
                  ),
                ),
                horizontalSpacer(20),
                Expanded(
                  child: CustomButton(
                    height: 45,
                    title: "Start",
                    onTap: onTap,
                    fontSize: 16,
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
