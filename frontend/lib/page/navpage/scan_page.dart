// ignore: slash_for_doc_comments
/********************************************

QRCODE掃描要有介面計數 要掃描兩個QR
掃描區開大一點，不然很難對焦
沒跑動android模擬器到android/app/src/build.gradle修改line 31 49 50
只有動功能區域其他沒動

********************************************/

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/theme/constants.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/scanQRmodel.dart';
import 'package:frontend/page/scanpage/edit_food_page.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

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

  Barcode? result; // QR掃描存結果
  String datainfo = "";
  int twoQRcheck = 0; //步驟偵測
  QRViewController? controller; // 控制器 不要刪
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
              height: 16,
            ),
            Column(
              children: [
                if (twoQRcheck < 2) ...[
                  //* Qr Scanner
                  Container(
                    width: double.infinity,
                    height: 400,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: QRView(
                        key: qrkey,
                        onQRViewCreated: _onQRViewCreated,
                        onPermissionSet: (ctrl, p) =>
                            _onPermissionSet(context, ctrl, p),
                      ),
                    ),
                  ),
                ] else ...[
                  //* 確認按鈕
                  Container(
                    width: double.infinity,
                    height: 400,
                    alignment: Alignment.center,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const EditFoodPage();
                              },
                            ),
                          );
                        },
                        child: const CircleAvatar(
                          backgroundColor: primaryColor7,
                          radius: 100,
                          child: Text(
                            '掃描完成！',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ), //Text
                        ),
                      ), //CircleAvatar
                    ),
                  ),
                ],
              ],
            ),
            ProgressStepper(
              width: 200,
              height: 25,
              color: secondary6,
              progressColor: primaryColor5,
              stepCount: 3,
              builder: (index) {
                double widthOfStep = 200 / 3;
                if (index == twoQRcheck + 1) {
                  return ProgressStepWithChevron(
                    width: widthOfStep,
                    defaultColor: secondary6,
                    progressColor: primaryColor5,
                    wasCompleted: true,
                  );
                }
                return ProgressStepWithChevron(
                  width: widthOfStep,
                  defaultColor: secondary6,
                  progressColor: primaryColor5,
                  wasCompleted: false,
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            header(),
          ],
        ),
      ),
    );
  }

  //-------------------------步驟提示文字
  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(
                Icons.lightbulb,
                color: secondary5,
                size: 32,
              ),
              Text(
                headerText(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: chineseFontfamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String headerText() {
    switch (twoQRcheck) {
      case 1:
        return '先掃描右邊的 QR Code';
      case 2:
        return '完成！';
      default:
        return '先掃描左邊的 QR Code';
    }
  }

  //-------------------------QRcode掃瞄功能區
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    var resultcheck;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        qrdecode(result!.code);
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  //*解碼訊息
  void qrdecode(String? qrdata) {
    if (datainfo != qrdata) {
      twoQRcheck++;
      datainfo = datainfo + qrdata!;
    }
    if (twoQRcheck == 2) {
      datainfo = datainfo.substring(95);
      if (datainfo.contains("**")) {
        datainfo = datainfo + datainfo.substring(2);
        var goodinfo = datainfo.split(":");
        for (int cargosort = 0; cargosort < goodinfo.length; cargosort += 3) {
          insert_data(goodinfo[cargosort], goodinfo[cargosort + 1],
              goodinfo[cargosort + 2]);
        }
      }
      twoQRcheck = 0;
      datainfo = "";
    }
  }

  void insert_data(String n, String co, String cs) async {
    var _id = M.ObjectId();
    final data = Goods(id: _id, name: n, count: co, cost: cs);
    var result = await MongoDatabase.insertscan(data);
  }
}
