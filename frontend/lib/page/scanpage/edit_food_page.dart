// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:frontend/theme/constants.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/user_allstorefood_model.dart';
import 'package:frontend/models/data/scanFood/edititem_data.dart';
import 'package:frontend/models/food_edit_carditem.dart';
import 'package:frontend/page/scanpage/food_detail_page.dart';

class EditFoodPage extends StatefulWidget {
  const EditFoodPage({Key? key}) : super(key: key);

  @override
  State<EditFoodPage> createState() => _EditFoodPageState();
}

class _EditFoodPageState extends State<EditFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 32, top: 36, right: 24),
        //! Incorrect use of ParentDataWidget. <-- 錯誤訊息不知道哪出錯了：）
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "匯入編輯",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    fontFamily: chineseFontfamily,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            //* 搜尋 Bar
            Flexible(
              flex: 1,
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: ' Search',
                    hintStyle: const TextStyle(
                        color: primaryColor2,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: englishFontfamily),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(16),
                      child: const Icon(
                        Icons.search_rounded,
                        size: 28,
                        color: primaryColor3,
                      ),
                      width: 16,
                    )),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            //* 食物卡
            Row(
              children: [
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: 5,
                      separatorBuilder: (context, _) =>
                          const SizedBox(width: 12),
                      itemBuilder: (context, index) =>
                          buildCard(edit_item: foods[index]),
                    ),
                  ),
                ),
              ],
            ),
            //* 底部兩顆按鈕
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "匯入倉庫",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: chineseFontfamily,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      primary: primaryColor5,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "重新掃描",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: chineseFontfamily,
                        color: textColor,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
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
  }

  Widget buildCard({required FoodItem edit_item}) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditDetailPage(edit_item: edit_item),
          ),
        ),
        child: Container(
          height: 88,
          padding: const EdgeInsets.only(bottom: 16),
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
                  height: 100,
                  width: 100,
                  child: Expanded(
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Material(
                          child: Ink.image(
                            image: NetworkImage(
                              edit_item.urlImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      Text(
                        edit_item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: englishFontfamily,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        edit_item.date,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: englishFontfamily,
                        ),
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
