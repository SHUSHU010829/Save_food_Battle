import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../theme/size_config.dart';

class BillScan extends StatefulWidget {
  //const BillScan({Key? key}) : super(key: key);
  final Function toggleView;
  const BillScan({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<BillScan> createState() => _BillScanPageState();
}

class _BillScanPageState extends State<BillScan> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          buildQrView(context),
        ],
      ),
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrkey,
        onQRViewCreated: onQRViewCreated,
      );
  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
  }
}
