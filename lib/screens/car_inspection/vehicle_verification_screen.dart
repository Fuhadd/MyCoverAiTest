import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:screenshot/screenshot.dart';
import 'package:test_design/constants/custom_colors.dart';
import 'package:test_design/constants/custom_string.dart';
import 'package:test_design/screens/car_inspection/test_screen.dart';
import 'package:test_design/utils/spacers.dart';
import 'package:test_design/widgets/capture_side_container.dart';
import 'package:test_design/widgets/start_side_container.dart';

class VehicleVerificationScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const VehicleVerificationScreen({super.key, required this.cameras});

  @override
  State<VehicleVerificationScreen> createState() =>
      _VehicleVerificationScreenState();
}

class _VehicleVerificationScreenState extends State<VehicleVerificationScreen> {
  final GlobalKey _globalKey = GlobalKey();
  Uint8List? _imageFile;
  ScreenshotController screenshotController = ScreenshotController();
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
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CameraPreview(
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
                                                      decoration: BoxDecoration(
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
                                                                            bottom:
                                                                                7.0),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              28,
                                                                          width:
                                                                              28,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                CustomColors.grayiconColor.withOpacity(0.9),
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              Icon(
                                                                            Icons.check,
                                                                            color:
                                                                                CustomColors.whiteColor.withOpacity(0.6),
                                                                            size:
                                                                                18,
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

                                    CaptureSideContainer(
                                      onTap: () async {
                                        // final image =
                                        //     await controller.takePicture();
                                        _imageFile = await screenshotController
                                            .capture();
                                        if (_imageFile != null) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content:
                                                    Image.memory(_imageFile!),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Retake'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      // captureImage();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child:
                                                        const Text('Continue'),
                                                    onPressed: () {
                                                      // Continue with your logic
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }

                                        // Display the captured image
                                      },
                                    ),
                                    // const StartSideContainer(),
                                  ],
                                ),
                              ),
                              Screenshot.(
                                controller: screenshotController,
                                child: Container(
                                  height: 300,
                                  width: 300,
                                  color: Colors.transparent,
                                  // decoration: BoxDecoration(
                                  //     border: Border.all(color: Colors.black)),
                                  // child: CameraPreview(controller),
                                ),
                              )
                            ],
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

  Future<void> captureAndSave() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    // Now you can save or use the captured image (pngBytes)
    // Example: save to file
    final directory = (await getApplicationDocumentsDirectory()).path;
    File('$directory/captured_image.png').writeAsBytesSync(pngBytes);
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final Color? color;
  final double height;
  final Color? titleColor;
  const CustomButton({
    super.key,
    required this.title,
    this.color = CustomColors.greenColor,
    this.height = 50,
    this.titleColor = CustomColors.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
