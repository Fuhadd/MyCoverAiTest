import 'package:flutter/material.dart';
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
