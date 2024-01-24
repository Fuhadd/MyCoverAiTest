import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:screenshot/screenshot.dart';
import 'package:test_design/constants/custom_colors.dart';
import 'package:test_design/constants/custom_string.dart';
import 'package:test_design/screens/app_view_model.dart';
import 'package:test_design/utils/enum.dart';
import 'package:test_design/utils/spacers.dart';
import 'package:test_design/widgets/capture_side_container.dart';
import 'package:test_design/widgets/countdown_timer.dart';
import 'package:test_design/widgets/start_side_container.dart';
import 'package:test_design/widgets/verify_side_container.dart';

class VehicleVerificationScreen extends StatefulHookConsumerWidget {
  final List<CameraDescription> cameras;
  const VehicleVerificationScreen({super.key, required this.cameras});

  @override
  ConsumerState<VehicleVerificationScreen> createState() =>
      _VehicleVerificationScreenState();
}

class _VehicleVerificationScreenState
    extends ConsumerState<VehicleVerificationScreen> {
  final GlobalKey _globalKey = GlobalKey();
  Uint8List? _imageFile;
  ScreenshotController screenshotController = ScreenshotController();
  late CameraController controller;
  bool showCaptureScreen = false;

  @override
  void initState() {
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: (controller.value.isInitialized)
            ? Column(
                children: [
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? Expanded(
                          child: CameraPreview(
                          controller,
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
                              // verticalSpacer(10.h),
                              Text(
                                "Rotate Device",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: CustomColors.whiteColor),
                              ),
                            ],
                          ),
                        ))
                      : Expanded(
                          child: SizedBox(
                          width: double.infinity,
                          child: (ref.watch(verificationStepProvider) ==
                                      CarVerificationStep.leftSideCapture ||
                                  ref.watch(verificationStepProvider) ==
                                      CarVerificationStep.rightSideCapture ||
                                  ref.watch(verificationStepProvider) ==
                                      CarVerificationStep.frontSideCapture)
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Screenshot(
                                      controller: screenshotController,
                                      child: Container(
                                        height: 1.sh,
                                        width: 1.sw,
                                        // color: Colors.transparent,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: CameraPreview(controller),
                                      ),
                                    ),
                                  ],
                                )
                              : CameraPreview(
                                  controller,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 10,
                                              left: 10,
                                              top: MediaQuery.of(context)
                                                      .padding
                                                      .top +
                                                  10,
                                              bottom: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: CustomColors
                                                      .success500Color,
                                                )),
                                            child: Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Expanded(
                                                        child: SizedBox()),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10.0),
                                                      child: CountdownTimer(),
                                                    ),
                                                    const Expanded(
                                                        child: SizedBox()),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Container(
                                                        width: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: CustomColors
                                                              .transGrayColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 8.0),
                                                              child: ListView
                                                                  .builder(
                                                                      itemCount:
                                                                          6,
                                                                      shrinkWrap:
                                                                          true,
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              bottom: 7.0),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                28,
                                                                            width:
                                                                                28,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: CustomColors.grayiconColor.withOpacity(0.9),
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            child:
                                                                                Icon(
                                                                              Icons.check,
                                                                              color: CustomColors.whiteColor.withOpacity(0.6),
                                                                              size: 18,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const Expanded(
                                                        child: SizedBox()),
                                                  ],
                                                ),
                                                Expanded(child: Container()),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      (ref.watch(verificationStepProvider) ==
                                                  CarVerificationStep
                                                      .leftSideVerify ||
                                              ref.watch(
                                                      verificationStepProvider) ==
                                                  CarVerificationStep
                                                      .rightSideVerify ||
                                              ref.watch(
                                                      verificationStepProvider) ==
                                                  CarVerificationStep
                                                      .frontSideVerify)
                                          ? const VerifySideContainer()
                                          : StartSideContainer(
                                              step: ref.watch(
                                                  verificationStepProvider),
                                              onTap: () {
                                                var currentStep = ref.watch(
                                                    verificationStepProvider);
                                                if (currentStep ==
                                                    CarVerificationStep
                                                        .leftSidePreCapture) {
                                                  ref
                                                          .read(
                                                              verificationStepProvider
                                                                  .notifier)
                                                          .state =
                                                      CarVerificationStep
                                                          .leftSideCapture;
                                                } else if (currentStep ==
                                                    CarVerificationStep
                                                        .rightSidePreCapture) {
                                                  ref
                                                          .read(
                                                              verificationStepProvider
                                                                  .notifier)
                                                          .state =
                                                      CarVerificationStep
                                                          .rightSideCapture;
                                                } else {
                                                  ref
                                                          .read(
                                                              verificationStepProvider
                                                                  .notifier)
                                                          .state =
                                                      CarVerificationStep
                                                          .frontSideCapture;
                                                }
                                              },
                                            ),
                                    ],
                                  ),
                                ),
                        )),
                ],
              )
            : Container()

        //  MediaQuery.of(context).orientation == Orientation.portrait
        //     ? const Center(
        //         child: Text("Portrait"),
        //       )
        //     : const Center(
        //         child: Text("Landscape"),
        //       ),
        );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final Color? color;
  final double height;
  final Color? titleColor;
  final void Function()? onTap;
  const CustomButton({
    super.key,
    required this.title,
    this.color = CustomColors.greenColor,
    this.height = 50,
    this.titleColor = CustomColors.whiteColor,
    this.onTap,
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
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: titleColor,
            ),
          ),
        ),
      ),
    );
  }
}
