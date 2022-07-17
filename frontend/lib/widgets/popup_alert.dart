import 'package:flutter/material.dart';
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
            title: Row(
              children: const [
                Text(
                  '通知',
                  style: TextStyle(
                    color: primaryColor9,
                    fontFamily: chineseFontfamily,
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "按＋加入購物車",
                  style: TextStyle(
                    color: primaryColor3,
                    fontFamily: chineseFontfamily,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            contentPadding: const EdgeInsets.all(20.0),
            content: Container(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.error,
                        size: 20.0,
                      ),
                      SizedBox(
                        width: 16,
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
                    height: 24,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontFamily: englishFontfamily),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'AddCart'),
                child: const Text(
                  '加入購物車',
                  style: TextStyle(
                    fontFamily: chineseFontfamily,
                    fontWeight: FontWeight.w500,
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
