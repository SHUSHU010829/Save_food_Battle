import 'package:flutter/material.dart';

class QrScanWidget extends StatefulWidget {
  const QrScanWidget({Key? key}) : super(key: key);

  @override
  State<QrScanWidget> createState() => _QrScanWidgetState();
}

class _QrScanWidgetState extends State<QrScanWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Column(
          //   children: [
          //     ElevatedButton(
          //       onPressed: () {},
          //       child: const Icon(Icons.highlight),
          //       style: ButtonStyle(
          //         shape: MaterialStateProperty.all(const CircleBorder()),
          //         padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
          //         backgroundColor: MaterialStateProperty.all(
          //             primaryColor5), // <-- Button color
          //         overlayColor: MaterialStateProperty.resolveWith<Color?>(
          //           (states) {
          //             if (states.contains(MaterialState.pressed)) {
          //               return primaryColor2;
          //             }
          //             return null; // <-- Splash color
          //           },
          //         ),
          //       ),
          //     ),
          //     const SizedBox(height: 8),
          //     ElevatedButton(
          //       onPressed: () {},
          //       child: const Icon(Icons.edit),
          //       style: ButtonStyle(
          //         shape: MaterialStateProperty.all(const CircleBorder()),
          //         padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
          //         backgroundColor: MaterialStateProperty.all(
          //             primaryColor5), // <-- Button color
          //         overlayColor: MaterialStateProperty.resolveWith<Color?>(
          //           (states) {
          //             if (states.contains(MaterialState.pressed)) {
          //               return primaryColor2;
          //             }
          //             return null; // <-- Splash color
          //           },
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Container(
            // width: double.infinity,
            // height: 200,
            alignment: Alignment.center,
            child: Container(
              width: 180,
              height: 180,
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
    );
  }
}
