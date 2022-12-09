import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/theme/constants.dart';
import 'package:frontend/page/settingpage/user_setting_page.dart';
// import 'package:frontend/models/article_model.dart';
// import 'package:frontend/network/network_enums.dart';
// import 'package:frontend/network/network_helper.dart';
// import 'package:frontend/network/network_service.dart';
// import 'package:frontend/network/query_param.dart';
// import 'package:frontend/static/static_values.dart';
// import 'package:frontend/widgets/article_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final user = FirebaseAuth.instance.currentUser!;
  double width = 200, height = 200;

  @override
  Widget build(BuildContext context) {
    RendererBinding.instance.setSemanticsEnabled(true);
    return Scaffold(
      backgroundColor: backgroundColor,
      // appBar: AppBar(
      //   title: const Text('Api 串接練習'),
      //   centerTitle: true,
      // ),
      body: Container(
        padding: const EdgeInsets.only(left: 32, top: 40, right: 24),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Setting",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        fontFamily: englishFontfamily,
                        color: textColor,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "努力開發中：）",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: chineseFontfamily,
                        color: secondary4,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/頭像.png'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: const [
                Icon(
                  Icons.border_color_rounded,
                  color: primaryColor7,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "系統設定",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    fontFamily: chineseFontfamily,
                    color: textColor,
                  ),
                )
              ],
            ),
            const Divider(
              height: 24,
              thickness: 2,
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const UserSettingPage();
                      },
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "用戶設定",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: chineseFontfamily,
                        color: textColor,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            buildAccountoptionRow(context, "新增群組"),
            buildAccountoptionRow(context, "成員編輯"),
            buildAccountoptionRow(context, "群組編輯"),
            buildAccountoptionRow(context, "外觀設定"),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: const [
                Icon(
                  Icons.volume_up_rounded,
                  color: primaryColor7,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "通知",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    fontFamily: chineseFontfamily,
                    color: textColor,
                  ),
                )
              ],
            ),
            const Divider(
              height: 24,
              thickness: 2,
            ),
            const SizedBox(
              height: 8,
            ),
            buildNotificationOptionRow("購物通知", false),
            buildNotificationOptionRow("群組通知", false),
            buildNotificationOptionRow("即期食物食用提醒", false),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text(
                  "Sign Out",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: englishFontfamily,
                    color: textColor,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //* 設定
  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: chineseFontfamily,
            color: textColor,
          ),
        ),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            value: isActive,
            onChanged: (bool val) {
              setState(() {});
            },
            activeColor: primaryColor8,
            trackColor: primaryColor1,
          ),
        ),
      ],
    );
  }

  GestureDetector buildAccountoptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // title: Text(
              //   title,
              //   style: const TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w700,
              //     fontFamily: chineseFontfamily,
              //     color: textColor,
              //   ),
              // ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "開發中 ⸜(๑˙ᵕ ˙๑)⸝ ",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: chineseFontfamily,
                    ),
                  ),
                  // Text(
                  //   "Option 1",
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w500,
                  //     fontFamily: englishFontfamily,
                  //   ),
                  // ),
                  // Text(
                  //   "Option 2",
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w500,
                  //     fontFamily: englishFontfamily,
                  //   ),
                  // ),
                  // Text(
                  //   "Option 3",
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w500,
                  //     fontFamily: englishFontfamily,
                  //   ),
                  // ),
                ],
              ),
              // actions: [
              // TextButton(
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              //   child: const Text(
              //     "Close",
              //     style: TextStyle(
              //       fontWeight: FontWeight.w500,
              //       fontFamily: englishFontfamily,
              //     ),
              //   ),
              // ),
              // ],
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: chineseFontfamily,
                color: textColor,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
