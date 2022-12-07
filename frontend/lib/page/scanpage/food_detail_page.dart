import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/theme/constants.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/alertFood_model.dart';
import 'package:frontend/models/user_allstorefood_model.dart';
import 'package:frontend/page/storefood/money_separate.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:frontend/models/food_edit_carditem.dart';

// ignore: must_be_immutable
class EditDetailPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final FoodItem edit_item;

  const EditDetailPage({
    Key? key,
    // ignore: non_constant_identifier_names
    required this.edit_item,
  }) : super(key: key);

  @override
  State<EditDetailPage> createState() => _EditDetailPageState();
}

class _EditDetailPageState extends State<EditDetailPage> {
  List<String> items = ["冷藏", "冷凍", "儲藏室"];
  List<String> types = ['甜點', '肉類', '蔬菜', '水果', '其他'];

  String? dropdownValue = '甜點';
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          padding: const EdgeInsets.only(left: 32, top: 36, right: 24),
          child: ListView(
            children: [
              //* 標頭
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      Text(
                        "Import",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w500,
                          fontFamily: englishFontfamily,
                          color: textColor,
                        ),
                      ),
                      Text(
                        "預設系統推薦選項",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: chineseFontfamily,
                          color: primaryColor2,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.highlight_off,
                      size: 32,
                      color: primaryColor7,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  Text(
                    widget.edit_item.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      fontFamily: englishFontfamily,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              //* 存放地點
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      Text(
                        "存放地點",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: chineseFontfamily,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_box,
                      size: 32,
                      color: primaryColor7,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: items.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) => Container(
                          height: 100,
                          width: 110,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            border: Border.all(
                              color: primaryColor3,
                              width: 2,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Center(
                            child: Text(
                              items[index],
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: chineseFontfamily,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //* 有效日期
              const Text(
                "有效日期",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: chineseFontfamily,
                  color: textColor,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                      "-7",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: englishFontfamily,
                        color: textColor,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      side: const BorderSide(width: 3, color: primaryColor4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      size: 32,
                      color: primaryColor4,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      bottom: 5, // Space between underline and text
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.amber,
                          width: 2.0, // Underline thickness
                        ),
                      ),
                    ),
                    child: Text(
                      widget.edit_item.date,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: englishFontfamily,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.add_circle_outline,
                      size: 32,
                      color: primaryColor4,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                      "+7",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: englishFontfamily,
                        color: textColor,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      side: const BorderSide(width: 3, color: primaryColor4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              //* 數量＆類別
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "數量",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: chineseFontfamily,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(
                    width: 148,
                  ),
                  Column(
                    children: const [
                      Text(
                        "類別",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: chineseFontfamily,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                      "3",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: chineseFontfamily,
                        color: textColor,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 1.5, color: primaryColor7),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                      "盒(Boxs)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: chineseFontfamily,
                        color: textColor,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 1.5, color: primaryColor7),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Container(child: _dropDown()),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              //* 底部按鈕
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "分配食材",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: chineseFontfamily,
                          color: textColor,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Text(
                            "NEXT",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: chineseFontfamily,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 32,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        primary: primaryColor5,
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _dropDown() {
    return DecoratedBox(
      decoration: BoxDecoration(
        //color: primaryColor1,
        border: Border.all(
          color: primaryColor6,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(10),
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
              fontWeight: FontWeight.w700,
              fontFamily: chineseFontfamily,
            ),
            underline: Container(),
            items: types.map<DropdownMenuItem<String>>(
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
