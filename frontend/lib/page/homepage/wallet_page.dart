import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/widgets/wallet_widget.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 32, right: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 60,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "錢包",
                  style: TextStyle(
                    fontSize: 28,
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
          const SizedBox(
            height: 16,
          ),
          //* 錢包區塊
          InkWell(
            child: const WalletWidget(),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(
            height: 36,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "已花費",
                  style: TextStyle(
                    fontFamily: chineseFontfamily,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Divider(
                  indent: 0.0,
                  endIndent: 0.0,
                  thickness: 3,
                ),
                const SizedBox(
                  height: 8,
                ),
                //* 花費卡
                // ignore: todo
                //TODO 串上資料庫
                SizedBox(
                  height: 160,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 12, bottom: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: primaryColor4,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color.fromRGBO(250, 249, 246, 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "2022.06.20",
                                style: TextStyle(
                                  fontFamily: englishFontfamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "+ \$ 1,000",
                                style: TextStyle(
                                  fontFamily: englishFontfamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 12, bottom: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: primaryColor4,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color.fromRGBO(250, 249, 246, 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "2022.06.20",
                                style: TextStyle(
                                  fontFamily: englishFontfamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "+ \$ 1,000",
                                style: TextStyle(
                                  fontFamily: englishFontfamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  "未結清",
                  style: TextStyle(
                    fontFamily: chineseFontfamily,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Divider(
                  indent: 0.0,
                  endIndent: 0.0,
                  thickness: 3,
                ),
                // ignore: todo
                //TODO:未結清卡片
                SizedBox(
                  height: 160,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: primaryColor4,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color.fromRGBO(250, 249, 246, 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Row(
                                  children: const [
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "待開發：）",
                                      style: TextStyle(
                                        fontFamily: chineseFontfamily,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //* 完成服款按鈕
                              Container(
                                width: 45,
                                height: 90,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: primaryColor5,
                                    width: 2,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(6.0),
                                    bottomRight: Radius.circular(6.0),
                                  ),
                                  color: primaryColor5,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "完",
                                      style: TextStyle(
                                        fontFamily: chineseFontfamily,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: secondary2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "成",
                                      style: TextStyle(
                                        fontFamily: chineseFontfamily,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: secondary2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "付",
                                      style: TextStyle(
                                        fontFamily: chineseFontfamily,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: secondary2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "款",
                                      style: TextStyle(
                                        fontFamily: chineseFontfamily,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: secondary2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
