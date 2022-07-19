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
        appBar: AppBar(
          title: Text(all_card_item.title),
        ),
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.network(
                all_card_item.urlImage,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              all_card_item.title,
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
