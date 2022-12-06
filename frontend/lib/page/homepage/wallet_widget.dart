import 'package:flutter/material.dart';
import 'package:frontend/theme/constants.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryColor4,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(1, 4), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromRGBO(250, 249, 246, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "WALLETS",
                style: TextStyle(
                  fontFamily: englishSpecialFontfamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text(
                    "\$ ",
                    style: TextStyle(
                      fontFamily: englishFontfamily,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "20,600",
                    style: TextStyle(
                      fontFamily: englishFontfamily,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text(
                    "代繳：",
                    style: TextStyle(
                      fontFamily: chineseFontfamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "\$",
                    style: TextStyle(
                      fontFamily: englishFontfamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "0",
                    style: TextStyle(
                      fontFamily: englishFontfamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: TextButton(
          //     onPressed: () => {},
          //     child: const Text(
          //       "  See More  ",
          //       style: TextStyle(
          //         fontFamily: englishFontfamily,
          //         fontSize: 12,
          //         height: 1.0,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //     style: ButtonStyle(
          //       padding: MaterialStateProperty.all<EdgeInsets>(
          //         const EdgeInsets.all(12),
          //       ),
          //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //       foregroundColor: MaterialStateProperty.all<Color>(
          //         textColor,
          //       ),
          //       backgroundColor: MaterialStateProperty.all<Color>(
          //         primaryColor2,
          //       ),
          //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //         RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(16),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
