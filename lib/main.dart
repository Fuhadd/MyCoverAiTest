import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_design/screens/car_inspection/car_inspection_pageview.dart';
import 'package:test_design/screens/car_inspection/test_screen.dart';
import 'package:test_design/screens/car_inspection/vehicle_verification_screen.dart';
import 'package:test_design/style/custom_theme.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            title: 'Test Design',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.defaultAppTheme,
            // home: const CarInspectionPageView(),
            home: VehicleVerificationScreen(
              cameras: cameras,
            ),
          );
        });
  }
}
