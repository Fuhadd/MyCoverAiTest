// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:test_design/constants/custom_colors.dart';
import 'package:test_design/constants/custom_string.dart';
import 'package:test_design/screens/app_view_model.dart';
import 'package:test_design/screens/car_inspection_pageview.dart';
import 'package:test_design/utils/enum.dart';
import 'package:test_design/widgets/capture_side_container.dart';
import 'package:test_design/widgets/countdown_timer.dart';
import 'package:test_design/widgets/loading_side_container.dart';
import 'package:test_design/widgets/selected_image_container.dart';
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
  bool isLoading = false;
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
            break;

          default:
            break;
        }
      }
    });

    super.initState();
  }

  Future<void> checkPermissions() async {
    try {
      await controller.initialize();
    } on CameraException catch (e) {
      if (e.code == 'CameraAccessDenied') {
        // checkPermissions();
        //   showDialogModal(
        //     context: context,
        //     title: "Camera Permission Required",
        //     subTitle:
        //         "Please open settings, enable camera permission for the app, and restart the app to proceed with verification.",
        //     onPressed: () => openAppSettings(),
        //     okText: "Open Settings",
        //   );

        //   // Navigator.pop(context);
        // } else if (e.code == "AudioAccessDenied") {
        //   // checkPermissions();
        //   showDialogModal(
        //     context: context,
        //     title: "Audio Permission Required",
        //     subTitle:
        //         "Please open settings, enable audio permission for the app, and restart the app to proceed with verification.",
        //     onPressed: () => openAppSettings(),
        //     okText: "Open Settings",
        //   );

        // Navigator.pop(context);
      } else {
        // Handle other errors
      }
    }
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
                  //This checks if the device is either in portrait mode or landscape and shows the respective widgets
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
                          child:
                              //This condition checks if the user has reached any of the capture stages, then it shows the capture screen
                              (ref.watch(verificationStepProvider) ==
                                          CarVerificationStep.leftSideCapture ||
                                      ref.watch(verificationStepProvider) ==
                                          CarVerificationStep
                                              .rightSideCapture ||
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
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: CameraPreview(controller),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.sh,
                                          width: 1.sw,
                                          child: CameraPreview(
                                            controller,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10,
                                                        left: 10,
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .padding
                                                                .top +
                                                            10,
                                                        bottom: 10),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          border: Border.all(
                                                            color: CustomColors
                                                                .success500Color,
                                                          )),
                                                      child: Row(
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const Expanded(
                                                                  child:
                                                                      SizedBox()),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10.0),
                                                                child:
                                                                    CountdownTimer(),
                                                              ),
                                                              const Expanded(
                                                                  child:
                                                                      SizedBox()),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10.0),
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: CustomColors
                                                                        .transGrayColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            top:
                                                                                8.0),
                                                                        child: ListView.builder(
                                                                            itemCount: 6,
                                                                            shrinkWrap: true,
                                                                            padding: EdgeInsets.zero,
                                                                            itemBuilder: (context, index) {
                                                                              final verificationStep = ref.watch(verifiedCountProvider);
                                                                              final isStepCompleted = index < verificationStep;
                                                                              return Padding(
                                                                                padding: const EdgeInsets.only(bottom: 7.0),
                                                                                child: Container(
                                                                                  height: 28,
                                                                                  width: 28,
                                                                                  decoration: BoxDecoration(
                                                                                    color: isStepCompleted ? CustomColors.success500Color : CustomColors.grayiconColor.withOpacity(0.9),
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: Icon(
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
                                                                  child:
                                                                      SizedBox()),
                                                            ],
                                                          ),
                                                          Expanded(
                                                              child:
                                                                  Container()),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                CaptureSideContainer(
                                                  isLoading: isLoading,
                                                  onTap: () async {
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                                                    _imageFile =
                                                        await screenshotController
                                                            .capture();

                                                    ref
                                                        .read(
                                                            selectedImageFileProvider
                                                                .notifier)
                                                        .state = _imageFile;
                                                    if (_imageFile != null) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Center(
                                                            child: SelectedImageContainer(
                                                                imageFile:
                                                                    _imageFile),
                                                          );
                                                        },
                                                      );

                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 1), () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        var currentStep = ref.watch(
                                                            verificationStepProvider);
                                                        setState(() {
                                                          isLoading = false;
                                                        });

                                                        if (currentStep ==
                                                            CarVerificationStep
                                                                .leftSideCapture) {
                                                          ref
                                                                  .read(verificationStepProvider
                                                                      .notifier)
                                                                  .state =
                                                              CarVerificationStep
                                                                  .leftSideVerify;
                                                        } else if (currentStep ==
                                                            CarVerificationStep
                                                                .rightSideCapture) {
                                                          ref
                                                                  .read(verificationStepProvider
                                                                      .notifier)
                                                                  .state =
                                                              CarVerificationStep
                                                                  .rightSideVerify;
                                                        } else {
                                                          ref
                                                                  .read(verificationStepProvider
                                                                      .notifier)
                                                                  .state =
                                                              CarVerificationStep
                                                                  .frontSideVerify;
                                                        }
                                                      });
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : CameraPreview(
                                      controller,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                      color: (ref.watch(verificationStepProvider) == CarVerificationStep.leftSideVerify ||
                                                              ref.watch(
                                                                      verificationStepProvider) ==
                                                                  CarVerificationStep
                                                                      .rightSideVerify ||
                                                              ref.watch(
                                                                      verificationStepProvider) ==
                                                                  CarVerificationStep
                                                                      .frontSideVerify)
                                                          ? Colors.transparent
                                                          : CustomColors
                                                              .success500Color,
                                                    )),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Expanded(
                                                            child: SizedBox()),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10.0),
                                                          child:
                                                              CountdownTimer(),
                                                        ),
                                                        const Expanded(
                                                            child: SizedBox()),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10.0),
                                                          child: Container(
                                                            width: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: CustomColors
                                                                  .transGrayColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              8.0),
                                                                  child: ListView
                                                                      .builder(
                                                                          itemCount:
                                                                              6,
                                                                          shrinkWrap:
                                                                              true,
                                                                          padding: EdgeInsets
                                                                              .zero,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            final verificationStep =
                                                                                ref.watch(verifiedCountProvider);
                                                                            final isStepCompleted =
                                                                                index < verificationStep;
                                                                            return Padding(
                                                                              padding: const EdgeInsets.only(bottom: 7.0),
                                                                              child: Container(
                                                                                height: 28,
                                                                                width: 28,
                                                                                decoration: BoxDecoration(
                                                                                  color: isStepCompleted ? CustomColors.success500Color : CustomColors.grayiconColor.withOpacity(0.9),
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: Icon(
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
                                                    Expanded(
                                                        child: (ref.watch(verificationStepProvider) == CarVerificationStep.leftSideVerify ||
                                                                ref.watch(
                                                                        verificationStepProvider) ==
                                                                    CarVerificationStep
                                                                        .rightSideVerify ||
                                                                ref.watch(
                                                                        verificationStepProvider) ==
                                                                    CarVerificationStep
                                                                        .frontSideVerify)
                                                            ? Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        20.0),
                                                                child: SelectedImageContainer(
                                                                    imageFile:
                                                                        _imageFile),
                                                              )
                                                            : Container()),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          ref.watch(verificationStepProvider) ==
                                                  CarVerificationStep
                                                      .verificationLoading
                                              ? const LoadingSideContainer()
                                              : (ref.watch(
                                                              verificationStepProvider) ==
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
                                                  ? VerifySideContainer(
                                                      step: ref.watch(
                                                          verificationStepProvider),
                                                      onReCaptureTap: () {
                                                        var currentStep = ref.watch(
                                                            verificationStepProvider);
                                                        if (currentStep ==
                                                            CarVerificationStep
                                                                .leftSideVerify) {
                                                          ref
                                                                  .read(verificationStepProvider
                                                                      .notifier)
                                                                  .state =
                                                              CarVerificationStep
                                                                  .leftSideCapture;
                                                        } else if (currentStep ==
                                                            CarVerificationStep
                                                                .rightSideVerify) {
                                                          ref
                                                                  .read(verificationStepProvider
                                                                      .notifier)
                                                                  .state =
                                                              CarVerificationStep
                                                                  .rightSideCapture;
                                                        } else {
                                                          ref
                                                                  .read(verificationStepProvider
                                                                      .notifier)
                                                                  .state =
                                                              CarVerificationStep
                                                                  .frontSideCapture;
                                                        }
                                                      },
                                                      onVerifyTap: () async {
                                                        var currentStep = ref.watch(
                                                            verificationStepProvider);
                                                        ref
                                                                .read(verificationStepProvider
                                                                    .notifier)
                                                                .state =
                                                            CarVerificationStep
                                                                .verificationLoading;
                                                        await Future.delayed(
                                                            const Duration(
                                                                seconds: 1),
                                                            () {});
                                                        if (currentStep ==
                                                            CarVerificationStep
                                                                .leftSideVerify) {
                                                          ref
                                                                  .read(verificationStepProvider
                                                                      .notifier)
                                                                  .state =
                                                              CarVerificationStep
                                                                  .rightSidePreCapture;

                                                          ref
                                                              .read(
                                                                  verifiedCountProvider
                                                                      .notifier)
                                                              .state = 1;
                                                        } else if (currentStep ==
                                                            CarVerificationStep
                                                                .rightSideVerify) {
                                                          ref
                                                                  .read(verificationStepProvider
                                                                      .notifier)
                                                                  .state =
                                                              CarVerificationStep
                                                                  .frontSidePreCapture;

                                                          ref
                                                              .read(
                                                                  verifiedCountProvider
                                                                      .notifier)
                                                              .state = 2;
                                                        } else {
                                                          ref
                                                                  .read(verificationStepProvider
                                                                      .notifier)
                                                                  .state =
                                                              CarVerificationStep
                                                                  .verificationCompleted;

                                                          ref
                                                              .read(
                                                                  verifiedCountProvider
                                                                      .notifier)
                                                              .state = 9;

                                                          showDialogModal(
                                                              context: context,
                                                              title:
                                                                  "Verification Successful!",
                                                              subTitle:
                                                                  "Congratulations! Your verification process has been completed successfully.");
                                                        }
                                                      },
                                                    )
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
                                                                  .read(verificationStepProvider
                                                                      .notifier)
                                                                  .state =
                                                              CarVerificationStep
                                                                  .leftSideCapture;
                                                        } else if (currentStep ==
                                                            CarVerificationStep
                                                                .rightSidePreCapture) {
                                                          ref
                                                                  .read(verificationStepProvider
                                                                      .notifier)
                                                                  .state =
                                                              CarVerificationStep
                                                                  .rightSideCapture;
                                                        } else {
                                                          ref
                                                                  .read(verificationStepProvider
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
            : Container());
  }

  showDialogModal(
      {required BuildContext context,
      required String title,
      required String subTitle,
      final String? okText,
      void Function()? onPressed}) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Material(
              animationDuration: const Duration(milliseconds: 500),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 70,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      subTitle,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: onPressed ??
                          () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CarInspectionPageView()),
                                (route) => false);
                          },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.greenColor,
                      ),
                      child: Text(okText ?? "Okay"),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
