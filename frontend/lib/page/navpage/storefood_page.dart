import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/data/carditem1_data.dart';
import 'package:frontend/models/storefood_carditem1.dart';
import 'package:frontend/page/storefood/instant_food_page.dart';

class StorefoodPage extends StatefulWidget {
  const StorefoodPage({Key? key}) : super(key: key);

  @override
  State<StorefoodPage> createState() => _StorefoodPageState();
}

class _StorefoodPageState extends State<StorefoodPage> {
  List<String> items = ['Place1', 'Place2', 'Place3', 'Place4'];
  String? dropdownValue = 'Place1';
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          children: [
            Container(
              height: 136,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(48)),
                color: secondary1,
                gradient: LinearGradient(
                  colors: [
                    (Color.fromRGBO(253, 241, 194, 1)),
                    (Color.fromRGBO(253, 241, 194, 1)),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, right: 24.0, top: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimSearchBar(
                      width: 210,
                      textController: textController,
                      helpText: 'Search...',
                      onSuffixTap: () {
                        setState(() {
                          textController.clear();
                        });
                      },
                    ),
                    Container(child: _dropDown()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(width: 32),
                Text(
                  "即期食品",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: chineseFontfamily,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 160,
              padding: const EdgeInsets.only(left: 32, right: 24),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (context, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) =>
                    buildCard1(card_item: foods[index]),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(width: 24),
                Text( 
                  "全部食品",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: chineseFontfamily,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.separated(
                  itemCount: 6,
                  separatorBuilder: (context, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => buildCard2(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDown() {
    return DecoratedBox(
      decoration: BoxDecoration(
        //color: primaryColor1,
        border: Border.all(
          color: primaryColor6,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: SizedBox(
          width: 80.0,
          child: DropdownButton(
            isExpanded: true,
            value: dropdownValue,
            icon: const Icon(
              Icons.arrow_circle_down,
              color: primaryColor8,
              size: 24,
            ),
            elevation: 16,
            style: const TextStyle(
              color: primaryColor8,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: englishFontfamily,
            ),
            underline: Container(),
            items: items.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget buildCard1({
    // ignore: non_constant_identifier_names
    required CardItem card_item,
  }) =>
      SizedBox(
        width: 120,
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                    child: Ink.image(
                      image: NetworkImage(card_item.urlImage),
                      fit: BoxFit.cover,
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InstantFoodPage(
                              card_item: card_item,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              card_item.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: englishFontfamily,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              card_item.date,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: englishFontfamily,
              ),
            ),
          ],
        ),
      );

  Widget buildCard2() {
    return Container(
      height: 88,
      padding: const EdgeInsets.only(left: 32, right: 24, bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor9,
            width: 2,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: const [
            BoxShadow(
              color: primaryColor2,
              offset: Offset(6.0, 6.0), //陰影x軸偏移量
              blurRadius: 0, //陰影模糊程度
              spreadRadius: 0, //陰影擴散程度
            ),
          ],
        ),
      ),
    );
  }
}
