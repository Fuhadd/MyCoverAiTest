import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:test_design/constants/custom_colors.dart';
import 'package:test_design/constants/custom_string.dart';
import 'package:test_design/utils/spacers.dart';

class VehicleVerificationScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const VehicleVerificationScreen({super.key, required this.cameras});

  @override
  State<VehicleVerificationScreen> createState() =>
      _VehicleVerificationScreenState();
}

class _VehicleVerificationScreenState extends State<VehicleVerificationScreen> {
  late CameraController controller;

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
                          child: CameraPreview(
                            controller,
                            child: Row(
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
                                  "No Rotate Device",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                      color: CustomColors.whiteColor),
                                ),
                                Expanded(child: Container()),
                                Container(
                                  width: 1.sw * 0.35,
                                  color: CustomColors.transGray100Color,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
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
                                                  color: CustomColors
                                                      .success500Color),
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
                                    ],
                                  ),
                                )
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
