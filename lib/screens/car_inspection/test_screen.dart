import 'package:flutter/material.dart';
import 'package:test_design/constants/custom_colors.dart';
import 'package:test_design/utils/spacers.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                Container(color: Colors.red),
                Container(color: Colors.blue),
                Container(color: Colors.green),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(3, (int index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 40,
                width: (index == _currentPage) ? 100 : 20,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: (index == _currentPage) ? Colors.amber : Colors.grey,
                ),
                child: (index == _currentPage)
                    ? const Center(
                        child: Text(
                          "Step 1",
                          style: TextStyle(fontSize: 14),
                        ),
                      )
                    : const Text("1"),
              );
            }),
          ),
          verticalSpacer(50),
        ],
      ),
    );
  }
}

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
  void dispose() {
    controller.dispose(); // Dispose the AnimationController
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
