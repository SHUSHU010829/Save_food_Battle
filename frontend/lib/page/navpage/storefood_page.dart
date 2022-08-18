// ignore_for_file: non_constant_identifier_names

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/data/storefood/carditem1_data.dart';
import 'package:frontend/models/storefood_carditem1.dart';
import 'package:frontend/models/data/storefood/carditem2_data.dart';
import 'package:frontend/models/storefood_carditem2.dart';
import 'package:frontend/page/storefood/instant_food_page.dart';
// import 'package:frontend/page/storefood/food_detail_page.dart';
import 'package:frontend/page/storefood/foodDetail/food_detail.dart';

class StorefoodPage extends StatefulWidget {
  const StorefoodPage({Key? key}) : super(key: key);

  @override
  State<StorefoodPage> createState() => _StorefoodPageState();
}

class _StorefoodPageState extends State<StorefoodPage> {
  List<String> items = ['All', 'Place1', 'Place2', 'Place3', 'Place4'];
  String? dropdownValue = 'All';
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          children: [
            //* 搜尋調與切換儲存地點
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
            //* 即期食品卡片
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(width: 30),
                Text(
                  "即期食品",
                  style: TextStyle(
                    fontSize: 22,
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
            //* 全部食品卡片
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(width: 30),
                Text(
                  "全部食品",
                  style: TextStyle(
                    fontSize: 22,
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
                  itemCount: 5,
                  separatorBuilder: (context, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) =>
                      buildCard2(all_card_item: foods2[index]),
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

  Widget buildCard1({required CardItem card_item}) => SizedBox(
        width: 120,
        // height: 100,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
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

  Widget buildCard2({required AllCardItem all_card_item}) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetailPage(
              all_card_item: all_card_item,
            ),
          ),
        ),
        child: Container(
          height: 80,
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
                  blurRadius: 5, //陰影模糊程度
                  spreadRadius: 0, //陰影擴散程度
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                      child: Ink.image(
                        image: NetworkImage(
                          all_card_item.urlImage,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            all_card_item.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: englishFontfamily,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center, // 內裝元件置中對齊
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: secondary5, // 綠色背景
                                ),
                                child: Text(
                                  all_card_item.date,
                                  style: const TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: englishFontfamily,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center, // 內裝元件置中對齊
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: secondary6, // 綠色背景
                                ),
                                child: Text(
                                  all_card_item.place,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: textColor,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: englishFontfamily,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      //进度条显示40%，会显示一个半圆
                      CircularProgressIndicator(
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation(secondary4),
                        value: double.parse(all_card_item.use),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
