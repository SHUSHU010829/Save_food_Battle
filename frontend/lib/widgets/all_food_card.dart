// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/user_allstorefood_model.dart';
import 'package:frontend/page/storefood/insertFood/insert_food_page.dart';

class AllfoodCardWidget extends StatefulWidget {
  const AllfoodCardWidget({Key? key}) : super(key: key);

  @override
  State<AllfoodCardWidget> createState() => _AllfoodCardWidgetState();
}

class _AllfoodCardWidgetState extends State<AllfoodCardWidget> {
  DateTime dateNow = DateTime.now();
  DateTime deadline = DateTime.parse("2022-10-11 00:00:00");
  String result = 'No Result yet';
  var dayList = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: FutureBuilder(
          future: MongoDatabase.getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                var totalData = snapshot.data.length;
                // print("Total Data: " + totalData.toString());
                dayList.clear();
                for (int i = 0; i < totalData; i++) {
                  var mongodata = UserMongoDbModel.fromJson(snapshot.data[i]);
                  // print('${mongodata.year}-${mongodata.month}-${mongodata.day}');
                  deadline = DateTime.parse(
                      "${mongodata.year}-${mongodata.month}-${mongodata.day} 00:00:00");
                  int days = deadline.difference(dateNow).inDays;
                  if (days == 0) {
                    result = '今天過期!';
                  } else if (days < 0) {
                    result = '已經過期 ${-days} 天';
                  } else {
                    result = '還有 $days 天過期';
                  }
                  dayList.add(result);
                }
                // print(dayList);
                // 有效期限的計算
                return ListView.separated(
                  itemCount: snapshot.data.length,
                  separatorBuilder: (context, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => displayCard(
                      UserMongoDbModel.fromJson(snapshot.data[index]),
                      dayList[index]),
                );
              } else {
                return const Center(
                  child: Text("倉庫是空的喔！"),
                );
              }
            }
          },
        ),
      ),
    );
  }

  //* 全部食物卡片區
  Widget displayCard(UserMongoDbModel data, dayList) => GestureDetector(
        behavior: HitTestBehavior.translucent,
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
                const SizedBox(
                  width: 16,
                ),
                //* 圓形進度條
                CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation(secondary4),
                  value: double.parse(data.used) / 100,
                ),
                const SizedBox(
                  width: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  data.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: englishFontfamily,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                //* 有效期限：月日
                                Container(
                                  alignment: Alignment.center, // 內裝元件置中對齊
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: secondary5,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 1.0, bottom: 1.0),
                                    child: Center(
                                      child: Text(
                                        dayList,
                                        style: const TextStyle(
                                          color: textColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: englishFontfamily,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
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
                                        "# ${data.place}",
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
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const InsertFoodPage();
                                },
                                settings: RouteSettings(arguments: data)))
                        .then((value) {
                      setState(() {});
                    });
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ),
      );
}