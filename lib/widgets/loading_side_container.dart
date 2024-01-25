import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_design/constants/custom_colors.dart';
import 'package:test_design/constants/custom_string.dart';
import 'package:test_design/utils/spacers.dart';
import 'package:test_design/widgets/custom_button.dart';

class LoadingSideContainer extends StatelessWidget {
  const LoadingSideContainer({
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
                  text: "Verifying ",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: CustomColors.success500Color),
                ),
                TextSpan(
                  text: "Vehicle Image",
                ),
              ],
            ),
          ),
          verticalSpacer(30),
          SvgPicture.asset(
            ConstantString.loadingIcon,
            height: 60,
            // fit: BoxFit.cover,
          ),
          verticalSpacer(30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              "Hold on while we verify your image",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: CustomColors.whiteColor),
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    height: 45,
                    title: "Re capture",
                    titleColor: CustomColors.gray700Color,
                    color: CustomColors.whiteColor.withOpacity(0.4),
                  ),
                ),
                horizontalSpacer(20),
                Expanded(
                  child: CustomButton(
                    height: 45,
                    title: "Verify",
                    color: CustomColors.greenColor.withOpacity(0.4),
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
