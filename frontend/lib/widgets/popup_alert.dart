import 'package:flutter/material.dart';
import 'package:frontend/page/homepage/alret_foodcard.dart';
import '../theme/constants.dart';

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
            content: SizedBox(
              width: 0,
              height: 400,
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
                            icon: const Icon(Icons.close_rounded,),
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
        );
      },
    );
  }
}
