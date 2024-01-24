import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_design/constants/custom_colors.dart';
import 'package:test_design/constants/custom_string.dart';
import 'package:test_design/utils/enum.dart';
import 'package:test_design/utils/spacers.dart';

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
        child: Column(
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
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: CustomColors.lightGrayTextColor),
                children: [
                  const TextSpan(
                    text: 'It is important to note all these ',
                  ),
                  TextSpan(
                    text: "STEP",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: CustomColors.purple500Color),
                  ),
                  const TextSpan(
                    text: " before starting your Inspection ;",
                  )
                ],
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
                        var containerWidth = (constraints.maxWidth - (90)) / 10;
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
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      (index == _currentPage) ? 5 : 17.5.r),
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
                                              color: CustomColors.gray700Color),
                                          children: [
                                            const TextSpan(
                                              text: "STEP ",
                                            ),
                                            TextSpan(
                                              text: "${index + 1}",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
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
                                          color: CustomColors.gray400Color),
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
                                content: PageViewContent.displayPlainColor,
                                section1Text: "Park your Vehicle in a ",
                                section2Text: "well-lit, shaded, ",
                                section3text: "and ",
                                section4Text: "spacious area",
                                section5Text: ", ensuring there are ",
                                section6Text: "no obstructions.",
                                imageUrl: ConstantString.carFullView,
                              ),
                              PageViewContainer(
                                content: PageViewContent.displayGreenColor,
                                section3text: "front view",
                                imageUrl: ConstantString.carFrontView,
                              ),
                              PageViewContainer(
                                content: PageViewContent.displayGreenColor,
                                section3text: "Left view",
                                imageUrl: ConstantString.carLeftView,
                              ),
                              PageViewContainer(
                                content: PageViewContent.displayGreenColor,
                                section3text: "Back view",
                                imageUrl: ConstantString.carBackView,
                              ),
                              PageViewContainer(
                                content: PageViewContent.displayGreenColor,
                                section3text: "Right view",
                                imageUrl: ConstantString.carFrontViewNew,
                              ),
                              PageViewContainer(
                                content: PageViewContent.displayTextAndList,
                                section3text: "front view",
                                imageUrl: ConstantString.carChasisView,
                              ),
                              PageViewContainer(
                                content: PageViewContent.displayGreenColor,
                                section3text: "Dashboard",
                                imageUrl: ConstantString.carDashboardView,
                              ),
                              PageViewContainer(
                                content: PageViewContent.displayGreenColor,
                                section3text: "Interior Back",
                                imageUrl: ConstantString.carInteriorBackView,
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
                    child: GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          7, // last page
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      child: Container(
                        height: 50.h,
                        decoration:
                            const BoxDecoration(color: CustomColors.whiteColor),
                        child: Center(
                          child: Text(
                            "Skip",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                color: CustomColors.gray700Color),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: CustomColors.greenColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          _currentPage == 7 ? "Start Inspection" : "Next Step",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.whiteColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpacer((MediaQuery.of(context).padding.bottom) + 20.h),
          ],
        ),
      ),
    );
  }
}

class PageViewContainer extends StatelessWidget {
  final PageViewContent content;
  final String imageUrl;
  final String? section1Text,
      section2Text,
      section3text,
      section4Text,
      section5Text,
      section6Text;
  const PageViewContainer({
    super.key,
    required this.content,
    required this.imageUrl,
    this.section1Text,
    this.section2Text,
    this.section3text,
    this.section4Text,
    this.section5Text,
    this.section6Text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        content == PageViewContent.displayTextAndList
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          height: 1.8,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: CustomColors.gray700Color),
                      children: [
                        const TextSpan(
                          text: "Take picture of your  ",
                        ),
                        TextSpan(
                          text: "Vehicle's ",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: CustomColors.blackColor),
                        ),
                        TextSpan(
                          text: "Chassis no.",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: CustomColors.greenColor),
                        ),
                      ],
                    ),
                  ),
                  verticalSpacer(20.h),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: CustomColors.purple500Color, width: 1.5),
                        ),
                      ),
                      horizontalSpacer(10.w),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                // height: 1.8,

                                fontSize: 13.sp,
                                color: CustomColors.gray700Color),
                            children: [
                              const TextSpan(
                                text:
                                    "You can locate the chassis number on the ",
                              ),
                              TextSpan(
                                text: "front windshield, ",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: CustomColors.greenColor),
                              ),
                              const TextSpan(
                                text: "or",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpacer(20.h),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: CustomColors.purple500Color, width: 1.5),
                        ),
                      ),
                      horizontalSpacer(10.w),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                // height: 1.8,

                                fontSize: 13.sp,
                                color: CustomColors.gray700Color),
                            children: [
                              const TextSpan(
                                text: "You can find it on the ",
                              ),
                              TextSpan(
                                text: "interior door ",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: CustomColors.greenColor),
                              ),
                              const TextSpan(
                                text: "of the ",
                              ),
                              TextSpan(
                                text: "driver's side",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: CustomColors.greenColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            : RichText(
                text: TextSpan(
                  style: TextStyle(
                      height: 1.8,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: CustomColors.gray700Color),
                  children: [
                    TextSpan(
                      text: content == PageViewContent.displayGreenColor
                          ? "Take picture of your  "
                          : section1Text,
                    ),
                    TextSpan(
                      text: content == PageViewContent.displayGreenColor
                          ? "Vehicle's "
                          : section2Text,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.blackColor),
                    ),
                    TextSpan(
                      text: section3text,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: content == PageViewContent.displayGreenColor
                              ? CustomColors.greenColor
                              : CustomColors.gray700Color),
                    ),
                    TextSpan(
                      text: content == PageViewContent.displayGreenColor
                          ? ", ensuring it fills about "
                          : section4Text,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: content == PageViewContent.displayGreenColor
                            ? CustomColors.gray700Color
                            : CustomColors.blackColor,
                      ),
                    ),
                    TextSpan(
                      text: content == PageViewContent.displayGreenColor
                          ? "80%"
                          : section5Text,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: content == PageViewContent.displayGreenColor
                              ? CustomColors.success500Color
                              : CustomColors.gray700Color),
                    ),
                    TextSpan(
                      text: content == PageViewContent.displayGreenColor
                          ? "of your camera screen"
                          : section6Text,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: content == PageViewContent.displayGreenColor
                              ? CustomColors.gray700Color
                              : CustomColors.blackColor),
                    ),
                  ],
                ),
              ),
        verticalSpacer(60.h),

        Expanded(
            child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: CustomColors.gray100Color,
            borderRadius: BorderRadius.circular(12.r),
            // image: DecorationImage(
            //   image: AssetImage(imageUrl),
            //   fit: BoxFit.cover,
            // ),
          ),
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        )),
        // Expanded(
        //     child: DottedBorder(
        //   padding: EdgeInsets.zero,
        //   borderPadding: EdgeInsets.zero,
        //   borderType: BorderType.RRect,
        //   radius: Radius.circular(12.r),
        //   dashPattern: const [15, 13],
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        //     decoration: BoxDecoration(
        //       color: CustomColors.redColor,
        //       borderRadius: BorderRadius.circular(12.r),
        //       // image: DecorationImage(
        //       //   image: AssetImage(imageUrl),
        //       //   fit: BoxFit.cover,
        //       // ),
        //     ),
        //     child: Image.asset(
        //       imageUrl,
        //       fit: BoxFit.fill,
        //     ),
        //   ),
        // )),
      ],
    );
  }
}
