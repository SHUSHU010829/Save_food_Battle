import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/page/navpage/storefood_page.dart';

class InstantFoodPage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final CardItem card_item;

  const InstantFoodPage({
    Key? key,
    // ignore: non_constant_identifier_names
    required this.card_item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(card_item.title),
        ),
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.network(
                card_item.urlImage,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              card_item.title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                fontFamily: englishFontfamily,
              ),
            )
          ],
        ),
      );
}
