import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/tobuy_model.dart';
import 'package:frontend/page/homepage/tobuy_page.dart';
import 'package:frontend/widgets/popup_alert.dart';
import 'package:frontend/widgets/wallet_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TobuyModel> tobuys = [];
  TextEditingController tobuyController = TextEditingController(text: "");

  get mainAxisAlignment => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding:
            const EdgeInsets.only(left: 32, right: 32, top: 56, bottom: 32),
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
                      width: 16,
                    ),
                    const Text(
                      "Hi,",
                      style: TextStyle(
                        color: primaryColor9,
                        fontFamily: englishFontfamily,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      " User",
                      style: TextStyle(
                        color: primaryColor9,
                        fontFamily: englishFontfamily,
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                //* 提醒彈跳視窗
                // ignore: todo
                //TODO: 尚未完成
                const PopupAlert(),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            //* 錢包區塊
            InkWell(
              child: const WalletWidget(),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TobuyPage(),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            //* 購物清單
            // ignore: todo
            //TODO: 將清單併入首頁
            Center(
              child: OutlinedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Shopping List"),
                    SizedBox(width: 10),
                    Icon(Icons.add_shopping_cart_rounded)
                  ],
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TobuyPage(),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(width: 3.0, color: textColor2),
                  padding: const EdgeInsets.all(20.0),
                  fixedSize: const Size(300, 80),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: englishSpecialFontfamily,
                  ),
                  onPrimary: primaryColor9,
                  shadowColor: primaryColor1,
                  shape: const StadiumBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
