// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/theme/constants.dart';
import 'package:frontend/page/scanpage/stepper_widget.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:frontend/page/scanpage/edit_food_page.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  // this part is switch botton
  bool showScan = true;
  void toggleView() {
    setState(() => showScan = !showScan);
  }

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 32, top: 36, right: 24),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            //* BAR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Scan",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        fontFamily: englishFontfamily,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "發票/食物掃描",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: chineseFontfamily,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                ToggleSwitch(
                  minWidth: 64.0,
                  initialLabelIndex: 0,
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
            //* Qr Scanner
            const Expanded(child: StepperWidget()),
          ],
        ),
      ),
    );
  }
}
