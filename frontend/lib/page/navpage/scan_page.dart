import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/theme/constants.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/scanQRmodel.dart';
import 'package:frontend/models/user_allstorefood_model.dart';
import 'package:frontend/page/scanpage/edit_food_page.dart';
import 'package:frontend/page/scanpage/stepper_widget.dart';
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

  Barcode? result;            //QR掃描存結果
  String datainfo ="";        
  int twoQRcheck = 0;
  QRViewController? controller;   //控制器 不要刪
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  //權限控制 IOS有更新寫法到qr_code_scanner readme找
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
            Container(
              width: double.infinity,
              height: 400,
              alignment: Alignment.center,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.green[300],
                child: QRView(
                    key: qrkey,
                    onQRViewCreated: _onQRViewCreated,
                    onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
                  ),
                  /*child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditFoodPage(),
                    ),
                  ),
                ),*/
              ),
            ),
            //* 功能按鈕
            Container(
              padding: const EdgeInsets.only(left: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.highlight),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const CircleBorder()),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                          backgroundColor: MaterialStateProperty.all(
                              primaryColor5), // <-- Button color
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (states) {
                              if (states.contains(MaterialState.pressed)) {
                                return primaryColor2;
                              }
                              return null; // <-- Splash color
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.edit),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const CircleBorder()),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                          backgroundColor: MaterialStateProperty.all(
                              primaryColor5), // <-- Button color
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
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
                ],
              ),
            ),
          ],
        ),
      ),
      
    );
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
  void qrdecode(String? qrdata){
    if(datainfo != qrdata){
      twoQRcheck++;
      datainfo  = datainfo + qrdata!;  
    }
    if(twoQRcheck == 2){
      datainfo = datainfo.substring(95);
      if(datainfo.contains("**")){
        datainfo = datainfo + datainfo.substring(2);
        var goodinfo = datainfo.split(":");
        for(int cargosort = 0;cargosort < goodinfo.length;cargosort += 3){
          insert_data(goodinfo[cargosort],goodinfo[cargosort+1],goodinfo[cargosort+2]);
        }
      }
      twoQRcheck = 0;
      datainfo = "";
    }
  }
  void insert_data(String n,String co,String cs) async {
    var _id = M.ObjectId();
    final data = Goods(id: _id,name: n,count: co,cost: cs);
    var result = await MongoDatabase.insertscan(data);
  }
}
/********************************************

QRCODE掃描要有介面計數 要掃描兩個QR
掃描區開大一點，不然很難對焦
沒跑動android模擬器到android/app/src/build.gradle修改line 31 49 50
只有動功能區域其他沒動


********************************************/
