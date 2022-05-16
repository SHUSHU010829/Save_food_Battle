import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/page/scanpage/bill_scan_page.dart';
import 'package:frontend/page/scanpage/food_scan_page.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool showScan = true;
  void toggleView() {
    setState(() => showScan = !showScan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 32, top: 36, right: 24),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Scan",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    fontFamily: englishFontfamily,
                    color: textColor,
                  ),
                ),
                ToggleSwitch(
                  minWidth: 64.0,
                  initialLabelIndex: 1,
                  cornerRadius: 8.0,
                  activeFgColor: backgroundColor,
                  inactiveBgColor: textColor2,
                  inactiveFgColor: backgroundColor,
                  totalSwitches: 2,
                  //labels: const ['發票掃描', '食物辨識'],
                  icons: const [
                    Icons.payments,
                    Icons.set_meal,
                  ],
                  activeBgColors: const [
                    [primaryColor3],
                    [primaryColor4]
                  ],
                  onToggle: (index) {
                    // ignore: avoid_print
                    print('switched to: $index');
                    if (index == 1) {
                      showScan = true;
                    } else {
                      showScan = false;
                    }
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
