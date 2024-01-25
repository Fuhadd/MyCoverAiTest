import 'package:flutter/material.dart';
import 'package:test_design/constants/custom_colors.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with TickerProviderStateMixin {
  late AnimationController controller;

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 2),
    );
  }

  @override
  // Disposing the AnimationController
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          controller.reverse(
              from: controller.value == 0.0 ? 1.0 : controller.value);
          return AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget? child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          color: CustomColors.whiteColor,
                          shape: BoxShape.circle),
                      child: CircularProgressIndicator(
                        strokeWidth: 7.0,
                        valueColor:
                            const AlwaysStoppedAnimation(CustomColors.redColor),
                        value: controller.value,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Text(
                      timerString,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.redColor),
                    ),
                  ],
                );
              });
        });
  }
}
