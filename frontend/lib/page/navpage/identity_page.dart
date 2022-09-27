// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
// import 'package:frontend/page/scanpage/edit_food_page.dart';

class IdentityPage extends StatefulWidget {
  const IdentityPage({Key? key}) : super(key: key);

  @override
  State<IdentityPage> createState() => _IdentityPageState();
}

class _IdentityPageState extends State<IdentityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 32, top: 36, right: 24),
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            //* BAR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Food Identity",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        fontFamily: englishFontfamily,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "實景掃描",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: chineseFontfamily,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
