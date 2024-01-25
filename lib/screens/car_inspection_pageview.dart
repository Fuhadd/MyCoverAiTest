// ignore_for_file: use_build_context_synchronously

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:test_design/constants/custom_colors.dart';
import 'package:test_design/constants/custom_string.dart';
import 'package:test_design/screens/vehicle_verification_screen.dart';
import 'package:test_design/utils/enum.dart';
import 'package:test_design/utils/spacers.dart';
import 'package:test_design/widgets/custom_button.dart';
import 'package:test_design/widgets/page_view_container.dart';

class CarInspectionPageView extends StatefulWidget {
  const CarInspectionPageView({super.key});

  @override
  State<CarInspectionPageView> createState() => _CarInspectionPageViewState();
}

class _CarInspectionPageViewState extends State<CarInspectionPageView> {
  final PageController _pageController = PageController();

  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: MediaQuery.of(context).orientation == Orientation.landscape
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      ConstantString.rotatePhone,
                      height: 250.h,
                      width: 250.h,
                      animate: true,
                      repeat: true,
                      reverse: false,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "Rotate Device",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.gray700Color),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  verticalSpacer((MediaQuery.of(context).padding.top) + 35.h),
                  Text(
                    "Step on how to inspect",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.gray700Color),
                  ),
                  verticalSpacer(25.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                            height: 1.3,
                            fontSize: 14.sp,
                            color: CustomColors.lightGrayTextColor),
                        children: [
                          const TextSpan(
                            text: 'It is important to note all these ',
                          ),
                          TextSpan(
                            text: "STEP",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: CustomColors.purple500Color),
                          ),
                          const TextSpan(
                            text: " before starting your Inspection ;",
                          )
                        ],
                      ),
                    ),
                  ),
                  verticalSpacer(25.h),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: CustomColors.purple50Color,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          children: [
                            verticalSpacer(30.h),
                            LayoutBuilder(builder: (context, constraints) {
                              var containerWidth =
                                  (constraints.maxWidth - (90)) / 10;
                              return Row(
                                // scrollDirection: Axis.horizontal, shrinkWrap: true,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List<Widget>.generate(8, (int index) {
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    height: 25.h,
                                    width: (index == _currentPage)
                                        ? (2 * containerWidth).w
                                        : containerWidth.w,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            (index == _currentPage)
                                                ? 5
                                                : 17.5.r),
                                        color: CustomColors.purple25Color),
                                    child: (index == _currentPage)
                                        ? Center(
                                            child: RichText(
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: CustomColors
                                                        .gray700Color),
                                                children: [
                                                  const TextSpan(
                                                    text: "STEP ",
                                                  ),
                                                  TextSpan(
                                                    text: "${index + 1}",
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: CustomColors
                                                            .purple500Color),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Center(
                                            child: Text(
                                            (index + 1).toString(),
                                            style: const TextStyle(
                                                color:
                                                    CustomColors.gray400Color),
                                          )),
                                  );
                                }),
                              );
                            }),
                            verticalSpacer(50.h),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: PageView(
                                  controller: _pageController,
                                  onPageChanged: (int page) {
                                    setState(() {
                                      _currentPage = page;
                                    });
                                  },
                                  children: const [
                                    PageViewContainer(
                                      content:
                                          PageViewContent.displayPlainColor,
                                      section1Text: "Park your Vehicle in a ",
                                      section2Text: "well-lit, shaded, ",
                                      section3text: "and ",
                                      section4Text: "spacious area",
                                      section5Text: ", ensuring there are ",
                                      section6Text: "no obstructions.",
                                      imageUrl: ConstantString.carFullView,
                                    ),
                                    PageViewContainer(
                                      content:
                                          PageViewContent.displayGreenColor,
                                      section3text: "front view",
                                      imageUrl: ConstantString.carFrontView,
                                      imageTitle: "Front View",
                                    ),
                                    PageViewContainer(
                                      content:
                                          PageViewContent.displayGreenColor,
                                      section3text: "Left view",
                                      imageUrl: ConstantString.carLeftView,
                                      imageTitle: "Left View ( Driver Side )",
                                    ),
                                    PageViewContainer(
                                      content:
                                          PageViewContent.displayGreenColor,
                                      section3text: "Back view",
                                      imageUrl: ConstantString.carBackView,
                                      imageTitle: "Back View",
                                    ),
                                    PageViewContainer(
                                      content:
                                          PageViewContent.displayGreenColor,
                                      section3text: "Right view",
                                      imageUrl: ConstantString.carRightView,
                                      imageTitle: "Right View",
                                    ),
                                    PageViewContainer(
                                      content:
                                          PageViewContent.displayTextAndList,
                                      section3text: "Chassis number",
                                      imageUrl: ConstantString.carChasisView,
                                      imageTitle: "Chassis number",
                                    ),
                                    PageViewContainer(
                                      content:
                                          PageViewContent.displayGreenColor,
                                      section3text: "Dashboard",
                                      imageUrl: ConstantString.carDashboardView,
                                      imageTitle: "Vehicle Dashboard",
                                    ),
                                    PageViewContainer(
                                      content:
                                          PageViewContent.displayGreenColor,
                                      section3text: "Interior Back",
                                      imageUrl:
                                          ConstantString.carInteriorBackView,
                                      imageTitle: "Vehicle Back View",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            verticalSpacer(30.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                  verticalSpacer(20.h),
                  Row(
                    children: [
                      Visibility(
                        visible: _currentPage != 7,
                        child: Expanded(
                          child: CustomButton(
                            onTap: () {
                              _pageController.animateToPage(
                                7, // last page
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            title: "Skip",
                            height: 50.h,
                            color: CustomColors.whiteColor,
                            fontSize: 16,
                            titleColor: CustomColors.gray700Color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          onTap: _currentPage == 7
                              ? () async {
                                  List<CameraDescription> cameras =
                                      await availableCameras();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            VehicleVerificationScreen(
                                          cameras: cameras,
                                        ),
                                      ));
                                }
                              : () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                          title: _currentPage == 7
                              ? "Start Inspection"
                              : "Next Step",
                          height: 50.h,
                          color: CustomColors.greenColor,
                          fontSize: 16,
                          titleColor: CustomColors.whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  //This calculates and substracts the bottom padding
                  verticalSpacer(
                      (MediaQuery.of(context).padding.bottom) + 20.h),
                ],
              ),
      ),
    );
  }
}
