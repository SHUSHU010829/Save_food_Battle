// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/page/auth/login_page.dart';
import 'package:frontend/page/navpage/home_page.dart';

class UserSettingPage extends StatefulWidget {
  const UserSettingPage({Key? key}) : super(key: key);

  @override
  State<UserSettingPage> createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  var displayName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            //* BAR
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 64, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "用戶設定",
                    style: TextStyle(
                      fontSize: 31,
                      fontWeight: FontWeight.w700,
                      fontFamily: chineseFontfamily,
                      color: textColor,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            //* UserName
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/頭像.png'),
                      ),
                    ),
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName ?? 'User',
                    style: const TextStyle(
                      color: primaryColor9,
                      fontFamily: englishFontfamily,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30.0, top: 54.0),
              child: Text(
                "更改使用者姓名",
                style: TextStyle(
                  fontFamily: chineseFontfamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            //* 輸入格子
            Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, top:8.0),
              child: TextFormField(
                controller: displayName,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: secondary3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText:
                      FirebaseAuth.instance.currentUser!.displayName ?? 'User',
                  hintStyle: const TextStyle(
                    color: primaryColor1,
                    fontWeight: FontWeight.w700,
                    fontFamily: chineseFontfamily,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 10.0),
                ),
              ),
            ),
            //* 確認送出按鈕
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 60, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      try {
                        FirebaseAuth.instance.currentUser!
                            .updateDisplayName(displayName.text.trim());
                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text(
                      "確認送出",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: chineseFontfamily,
                        color: textColor,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(width: 2, color: secondary3),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
