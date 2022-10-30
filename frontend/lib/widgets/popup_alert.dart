import 'package:flutter/material.dart';
import 'package:frontend/widgets/alret_foodcard.dart';
import '../constants.dart';

class PopupAlert extends StatefulWidget {
  const PopupAlert({Key? key}) : super(key: key);

  @override
  State<PopupAlert> createState() => _PopupAlertState();
}

class _PopupAlertState extends State<PopupAlert> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notifications),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.all(24.0),
            content: Container(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '通知',
                              style: TextStyle(
                                color: primaryColor9,
                                fontFamily: chineseFontfamily,
                                fontWeight: FontWeight.w800,
                                fontSize: 22,
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
                        const Text(
                          "按＋加入購物車",
                          style: TextStyle(
                            color: primaryColor3,
                            fontFamily: chineseFontfamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      indent: 0.0,
                      endIndent: 0.0,
                      thickness: 3,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.error,
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "即將耗盡",
                          style: TextStyle(
                            color: primaryColor7,
                            fontFamily: chineseFontfamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //* 食物卡
                    const AlertFoodCard(),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: secondary6,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: secondary3,
                        fontWeight: FontWeight.w700,
                        fontFamily: chineseFontfamily,
                      ),
                    ),
                    child: const Text('加入購物車'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
