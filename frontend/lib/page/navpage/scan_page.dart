import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
// import 'package:frontend/page/scanpage/edit_food_page.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
              height: 24,
            ),
            //* BAR
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
            const SizedBox(
              height: 40,
            ),
            //* Qr Scanner
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.highlight),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        backgroundColor: MaterialStateProperty.all(
                            primaryColor5), // <-- Button color
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (states) {
                            if (states.contains(MaterialState.pressed)) {
                              return primaryColor2;
                            }
                            return null; // <-- Splash color
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.edit),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        backgroundColor: MaterialStateProperty.all(
                            primaryColor5), // <-- Button color
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (states) {
                            if (states.contains(MaterialState.pressed)) {
                              return primaryColor2;
                            }
                            return null; // <-- Splash color
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 36),
                Container(
                  // width: double.infinity,
                  // height: 200,
                  alignment: Alignment.center,
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.green[300],
                    // child: InkWell(
                    //   onTap: () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const EditFoodPage(),
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
            //* 功能按鈕
            Container(
              padding: const EdgeInsets.only(left: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
