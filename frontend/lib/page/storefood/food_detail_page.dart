import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import '../../models/storefood_carditem2.dart';

class FoodDetailPage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final AllCardItem all_card_item;

  const FoodDetailPage({
    Key? key,
    // ignore: non_constant_identifier_names
    required this.all_card_item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          // title: Text(all_card_item.title),
          backgroundColor: primaryColor3,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 16, top: 16, right: 16, bottom: 40),
              alignment: Alignment.center, // 內裝元件置中對齊
              decoration: const BoxDecoration(
                // 裝飾內裝元件
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(24.0),
                ),
                color: primaryColor3, // 綠色背景
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      all_card_item.urlImage,
                      scale: 2.0,
                      fit: BoxFit.cover,
                      height: 100.0,
                      width: 100.0,
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        all_card_item.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: englishFontfamily,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center, // 內裝元件置中對齊
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: secondary3, // 綠色背景
                            ),
                            child: Text(
                              all_card_item.date,
                              style: const TextStyle(
                                color: secondary2,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: englishFontfamily,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center, // 內裝元件置中對齊
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: secondary5, // 綠色背景
                            ),
                            child: Text(
                              all_card_item.count,
                              style: const TextStyle(
                                fontSize: 18,
                                color: textColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: englishFontfamily,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center, // 內裝元件置中對齊
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: secondary6, // 綠色背景
                            ),
                            child: Text(
                              all_card_item.place,
                              style: const TextStyle(
                                fontSize: 18,
                                color: primaryColor8,
                                fontWeight: FontWeight.w500,
                                fontFamily: englishFontfamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 32, top: 24, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "剩餘份量",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          fontFamily: chineseFontfamily,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 300,
                      height: 100,
                      color: Colors.green[300],
                      child: InkWell(
                        onTap: () {},
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text(
                            "編輯食材",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: chineseFontfamily,
                              color: textColor,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
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
      );
}
