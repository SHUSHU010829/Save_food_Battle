// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/dbModel/scan_qrmodel.dart';
import 'package:frontend/models/dbModel/user_allstorefood_model.dart';
import 'package:frontend/page/scanpage/food_detail_page.dart';
import 'package:frontend/theme/constants.dart';

class EditFoodPage extends StatefulWidget {
  const EditFoodPage({Key? key}) : super(key: key);

  @override
  State<EditFoodPage> createState() => _EditFoodPageState();
}

class _EditFoodPageState extends State<EditFoodPage> {
  var titleController = TextEditingController();
  var keyWord = '';
  List _foodData = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/data/food_data.json');
    final data = await json.decode(response);
    setState(() {
      _foodData = data["items"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 32, top: 36, right: 24),
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
              height: 16,
            ),
            //* 提示文字
            Row(
              children: const [
                Icon(
                  Icons.lightbulb,
                  color: secondary5,
                  size: 18,
                ),
                Text(
                  "針對特定食材編輯完再匯入！",
                  style: TextStyle(
                    color: textColor2,
                    fontSize: 18,
                    fontFamily: chineseFontfamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            //* 食物卡
            SizedBox(
              height: 500,
              child: FutureBuilder(
                future: MongoDatabase().qrScanData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      if (snapshot.data.length == 0) {
                        return const Center(
                          child: Text('空資料，請再掃描一次！'),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return displayData(
                              ScanQrModel.fromJson(snapshot.data[index]),
                            );
                          },
                        );
                      }
                    } else {
                      return const Center(
                        child: Text('錯誤！'),
                      );
                    }
                  }
                },
              ),
            ),
            //* 底部按鈕
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        MongoDatabase().deleteAllQRData();
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
            ),
          ],
        ),
      ),
    );
  }

  Widget displayData(ScanQrModel data) => Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
        child: Slidable(
          //* 刪除卡片
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: ((context) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      content: const Text(
                        "確認刪除這項食物嗎？",
                        style: TextStyle(
                          fontFamily: chineseFontfamily,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontSize: 16, color: textColor2),
                          ),
                          onPressed: () {
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text(
                            "確認刪除",
                            style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                              fontFamily: chineseFontfamily,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () {
                            MongoDatabase.deleteQRData(data);
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                      ],
                    ),
                  );
                }),
                backgroundColor: const Color(0xffe86159),
                icon: Icons.delete_rounded,
                label: 'Delete',
              ),
            ],
          ),

          //* 編輯卡片
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: ((context) {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const FoodDetailPage();
                              },
                              settings: RouteSettings(arguments: data)))
                      .then((value) {
                    setState(() {});
                  });
                }),
                backgroundColor: white1,
                icon: Icons.edit_rounded,
                label: 'Edit',
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor9,
                width: 2,
              ),
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 12, bottom: 12),
              child: Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //* Name
                            SizedBox(
                              width: 180,
                              child: Text(
                                data.name,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: chineseFontfamily,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                //* 份數
                                Container(
                                  alignment: Alignment.center, // 內裝元件置中對齊
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: secondary5,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      top: 1.0,
                                      bottom: 1.0,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "# ${data.count}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: textColor,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: englishFontfamily,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                //* 存放地點
                                Container(
                                  alignment: Alignment.center, // 內裝元件置中對齊
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: secondary6,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                        top: 1.0,
                                        bottom: 1.0),
                                    child: Center(
                                      child: Text(
                                        "\$ ${data.cost}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: textColor,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: englishFontfamily,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
// 