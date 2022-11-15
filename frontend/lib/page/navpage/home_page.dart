// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/page/homepage/wallet_page.dart';
import 'package:frontend/widgets/popup_alert.dart';
import 'package:frontend/widgets/tobuy_widget.dart';
import 'package:frontend/widgets/wallet_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController tobuyController = TextEditingController(text: "");
  final user = FirebaseAuth.instance.currentUser!;

  get mainAxisAlignment => null;

  Future getUserName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final name = user.displayName;
        return name;
      }
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("發生一些錯誤，請重新登入帳號或是洽詢開發人員。"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(left: 32, right: 32, top: 60, bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //* 首頁 Bar
                  Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/頭像.png'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        "Hi, ",
                        style: TextStyle(
                          color: primaryColor9,
                          fontFamily: englishFontfamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser!.displayName ??
                            'User',
                        style: const TextStyle(
                          color: primaryColor9,
                          fontFamily: englishFontfamily,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  //* 提醒彈跳視窗
                  // ignore: todo
                  //TODO 尚未完成
                  const PopupAlert(),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              //* 錢包區塊
              InkWell(
                child: const WalletWidget(),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // 允许 bottomSheet 高度自定义
                    backgroundColor: backgroundColor,
                    builder: (BuildContext context) {
                      return SizedBox(
                        // height: 600,
                        child: Center(
                          child: Column(
                            children: const [
                              WalletPage(),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              const TobuyWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
