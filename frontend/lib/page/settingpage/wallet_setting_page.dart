// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/dbModel/wallet_model.dart';
import 'package:frontend/theme/constants.dart';
import 'package:frontend/page/auth/login_page.dart';
import 'package:frontend/page/navpage/home_page.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class WalletSettingPage extends StatefulWidget {
  const WalletSettingPage({Key? key}) : super(key: key);

  @override
  State<WalletSettingPage> createState() => _WalletSettingPageState();
}

class _WalletSettingPageState extends State<WalletSettingPage> {
  var displayName = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

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
              padding: const EdgeInsets.only(left: 18, top: 56, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "錢包設定",
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
            //* 確認送出按鈕
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 30, right: 30),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _insertData("0");
                    setState(() {});
                  },
                  child: const Text(
                    "開通錢包",
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 30, right: 30),
              child: Column(
                children: [
                  MediaQuery.removePadding(
                    //消除頂部空白
                    context: context,
                    removeTop: true,
                    child: FutureBuilder(
                      future: MongoDatabase().getWalletData(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.hasData) {
                            var totalData = snapshot.data.length;
                            if (totalData == 0) {
                              return const Center(
                                child: Text("目前沒有任何食物！"),
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) => displayCard(
                                WalletModel.fromJson(snapshot.data[index]),
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text("倉庫是空的喔！"),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    setState(() {});
  }

  //  開通錢包
  Future<void> _insertData(String pay) async {
    // print(user.uid);
    var _id = M.ObjectId();
    final data = WalletModel(
      uid: user!.uid.toString(),
      id: _id,
      pay: pay,
    );
    var result = await MongoDatabase.walletInsert(data)
        .whenComplete(() => Navigator.pop(context));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("開通錢包"),
      ),
    );
  }

  Widget displayCard(WalletModel data) => Padding(
        padding: const EdgeInsets.only(
          top: 12.0,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor9,
                width: 2,
              ),
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 12.0, right: 16.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "錢包一",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: chineseFontfamily,
                        ),
                      ),
                      Text(
                        "\$ ${data.pay}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: chineseFontfamily,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
