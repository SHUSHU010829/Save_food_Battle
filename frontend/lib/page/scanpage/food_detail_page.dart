import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/food_edit_carditem.dart';

class EditDetailPage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final FoodItem edit_item;

  const EditDetailPage({
    Key? key,
    // ignore: non_constant_identifier_names
    required this.edit_item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Import",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    fontFamily: englishFontfamily,
                    color: textColor,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/頭像.png'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              edit_item.title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                fontFamily: englishFontfamily,
              ),
            ),
          ],
        ),
      );
}
