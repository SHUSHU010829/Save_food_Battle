// ignore_for_file: non_constant_identifier_names, unused_element, library_prefixes, unused_local_variable

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:faker/faker.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/user_allstorefood_model.dart';
import 'package:frontend/page/storefood/insertFood/insert_food_page.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
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

  var titleController = TextEditingController();
  var yearController = TextEditingController();
  var monthController = TextEditingController();
  var dayController = TextEditingController();
  var countController = TextEditingController();
  var unitController = TextEditingController();
  var splaceController = TextEditingController();
  var smethodController = TextEditingController();
  var usedController = TextEditingController();

  //  int var =int.parse(yearController.text);
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const SizedBox(width: 1),
                  const Text(
                    "全部食品",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: chineseFontfamily,
                      color: textColor,
                    ),
                  ),
                  //* 添加食物
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InsertFoodPage(),
                        ),
                      );
                      // showModalBottomSheet<void>(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return Container(
                      //       height: 460,
                      //       color: secondary5,
                      //       child: Center(
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: <Widget>[
                      //             Padding(
                      //               padding: const EdgeInsets.all(10.0),
                      //               child: Column(
                      //                 children: [
                      //                   const Text(
                      //                     "Insert Data",
                      //                     style: TextStyle(
                      //                       fontSize: 22,
                      //                       fontWeight: FontWeight.w700,
                      //                       fontFamily: chineseFontfamily,
                      //                       color: textColor,
                      //                     ),
                      //                   ),
                      //                   TextField(
                      //                     controller: titleController,
                      //                     decoration: const InputDecoration(
                      //                         labelText: "Title"),
                      //                   ),
                      //                   Row(
                      //                     children: [
                      //                       Expanded(
                      //                         child: TextField(
                      //                           controller: yearController,
                      //                           decoration:
                      //                               const InputDecoration(
                      //                                   labelText: "year"),
                      //                         ),
                      //                       ),
                      //                       const SizedBox(
                      //                         width: 3,
                      //                       ),
                      //                       Expanded(
                      //                         child: TextField(
                      //                           controller: monthController,
                      //                           decoration:
                      //                               const InputDecoration(
                      //                                   labelText: "month"),
                      //                         ),
                      //                       ),
                      //                       const SizedBox(
                      //                         width: 3,
                      //                       ),
                      //                       Expanded(
                      //                         child: TextField(
                      //                           controller: dayController,
                      //                           decoration:
                      //                               const InputDecoration(
                      //                                   labelText: "day"),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   Row(
                      //                     children: [
                      //                       Expanded(
                      //                         child: TextField(
                      //                           controller: countController,
                      //                           decoration:
                      //                               const InputDecoration(
                      //                                   labelText: "數量"),
                      //                         ),
                      //                       ),
                      //                       const SizedBox(
                      //                         width: 3,
                      //                       ),
                      //                       Expanded(
                      //                         child: TextField(
                      //                           controller: unitController,
                      //                           decoration:
                      //                               const InputDecoration(
                      //                                   labelText: "單位"),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   Row(
                      //                     children: [
                      //                       Expanded(
                      //                         child: TextField(
                      //                           controller: splaceController,
                      //                           decoration:
                      //                               const InputDecoration(
                      //                                   labelText: "收納地點"),
                      //                         ),
                      //                       ),
                      //                       const SizedBox(
                      //                         width: 3,
                      //                       ),
                      //                       Expanded(
                      //                         child: TextField(
                      //                           controller: splaceController,
                      //                           decoration:
                      //                               const InputDecoration(
                      //                                   labelText: "收藏方式"),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   TextField(
                      //                     controller: usedController,
                      //                     decoration: const InputDecoration(
                      //                         labelText: "已使用"),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 3,
                      //             ),
                      //             Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 const SizedBox(
                      //                   width: 3,
                      //                 ),
                      //                 OutlinedButton(
                      //                   onPressed: () {
                      //                     _fakeData();
                      //                   },
                      //                   child: const Text("Genrerate"),
                      //                 ),
                      //                 ElevatedButton(
                      //                   onPressed: () {
                      //                     _insertData(
                      //                       titleController.text,
                      //                       yearController.text,
                      //                       monthController.text,
                      //                       dayController.text,
                      //                       countController.text,
                      //                       unitController.text,
                      //                       splaceController.text,
                      //                       smethodController.text,
                      //                       usedController.text,
                      //                     );
                      //                   },
                      //                   child: const Text('Enter'),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 3,
                      //                 ),
                      //               ],
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // );
                    },
                    child: const Text(
                      "新增食材",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: chineseFontfamily,
                        color: primaryColor8,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
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

  // Future<void> _insertData(
  //   String title,
  //   String year,
  //   String month,
  //   String day,
  //   String count,
  //   String unit,
  //   String place,
  //   String storeMethod,
  //   String used,
  // ) async {
  //   var _id = M.ObjectId(); // store Unique id inside our variable
  //   final data = UserMongoDbModel(
  //     id: _id,
  //     title: title,
  //     year: year,
  //     month: month,
  //     day: day,
  //     count: count,
  //     unit: unit,
  //     place: place,
  //     storeMethod: storeMethod,
  //     used: used,
  //   );
  //   var result = await MongoDatabase.insert(data);
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text("Inserted ID" + _id.$oid),
  //     ),
  //   );
  //   _clearAll();
  // }

  // void _clearAll() {
  //   titleController.text = "";
  //   yearController.text = "";
  //   monthController.text = "";
  //   dayController.text = "";
  //   countController.text = "";
  //   unitController.text = "";
  //   splaceController.text = "";
  //   smethodController.text = "";
  //   usedController.text = "";
  // }

  // void _fakeData() {
  //   final fakerFa = Faker(provider: FakerDataProvider());
  //   setState(() {
  //     titleController.text = fakerFa.lorem.word();
  //     yearController.text = Random().nextInt(22).toString();
  //     monthController.text = Random().nextInt(12).toString();
  //     dayController.text = Random().nextInt(31).toString();
  //     countController.text = Random().nextInt(10).toString();
  //     unitController.text = fakerFa.lorem.word();
  //     splaceController.text = fakerFa.lorem.word();
  //     smethodController.text = fakerFa.lorem.word();
  //     usedController.text = Random().nextInt(100).toString();
  //   });
  // }

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
