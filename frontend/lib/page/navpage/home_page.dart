import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/tobuy_model.dart';
import 'package:frontend/page/homepage/tobuy_page.dart';
import 'package:frontend/widgets/popup_alert.dart';

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
              child: Container(
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
                      //mainAxisAlignment: MainAxisAlignment.center,
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => {},
                        child: const Text(
                          "  See More  ",
                          style: TextStyle(
                            fontFamily: englishFontfamily,
                            fontSize: 12,
                            height: 1.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(12),
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: MaterialStateProperty.all<Color>(
                            textColor,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            primaryColor2,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
