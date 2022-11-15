import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';

class UserSettingPage extends StatefulWidget {
  const UserSettingPage({Key? key}) : super(key: key);

  @override
  State<UserSettingPage> createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "用戶設定",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: chineseFontfamily,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: primaryColor1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            //* UserName
            Text(
              FirebaseAuth.instance.currentUser!.displayName ?? 'User',
              style: const TextStyle(
                color: primaryColor9,
                fontFamily: englishFontfamily,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            //* 信箱
            //* 密碼
            //* 確認送出按鈕
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
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
            )
          ],
        ),
      ),
    );
  }
}
