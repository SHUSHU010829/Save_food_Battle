// ignore_for_file: non_constant_identifier_names, unused_local_variable, avoid_print, unnecessary_string_interpolations, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/page/storefood/insert_page.dart';
import 'package:frontend/page/storefood/search_food_page.dart';
import 'package:frontend/page/storefood/widgets/all_food_card.dart';

class StorefoodPage extends StatefulWidget {
  const StorefoodPage({Key? key}) : super(key: key);

  @override
  State<StorefoodPage> createState() => _StorefoodPageState();
}

class _StorefoodPageState extends State<StorefoodPage> {
  List<String> items = ['All', '冷藏', '冷凍', '櫃子'];
  String? dropdownValue = 'All';
  TextEditingController textController = TextEditingController();

  var titleController = TextEditingController();

  var yearController = TextEditingController();
  var monthController = TextEditingController();
  var dayController = TextEditingController();
  var countController = TextEditingController();
  // var unitController = TextEditingController();
  var splaceController = TextEditingController();
  var smethodController = TextEditingController();
  var usedController = TextEditingController();

  // get deadline => null;

  //  int var =int.parse(yearController.text);
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
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 32.0),
                child: Column(
                  //* 搜尋調與切換儲存地點
                  children: [
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(child: _dropDown()),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return SearchFoodPage();
                                        },
                                        settings:
                                            RouteSettings(arguments: null)))
                                .then((value) {
                              setState(() {});
                            });
                          },
                          child: Icon(
                            Icons.search_rounded,
                            color: primaryColor6,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(12),
                            primary: secondary1,
                            // borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: primaryColor6,
                              width: 2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            //* 全部食品卡片
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              //* 標頭＋按鈕
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                          builder: (BuildContext context) {
                            // return InsertFoodPage();
                            return InsertPage();
                          },
                          settings: RouteSettings(arguments: null),
                        ),
                      ).then((value) {
                        setState(() {});
                      });
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
            const SizedBox(height: 12),
            //* 食物卡片區
            AllfoodCardWidget(),
          ],
        ),
      ),
    );
  }

  //* 下落選單
  Widget _dropDown() {
    return DecoratedBox(
      decoration: BoxDecoration(
        //color: primaryColor1,
        border: Border.all(
          color: primaryColor6,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: SizedBox(
          width: 232.0,
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
}
