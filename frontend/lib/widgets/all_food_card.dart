// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/data/tobuy/tobuy_model.dart';
import 'package:frontend/models/user_allstorefood_model.dart';
import 'package:frontend/page/storefood/insertFood/insert_food_page.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

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
  var check = [];
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: FutureBuilder(
          future: MongoDatabase().getData(),
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
                check.clear();
                for (int i = 0; i < totalData; i++) {
                  var mongodata = UserMongoDbModel.fromJson(snapshot.data[i]);
                  // print('${mongodata.year}-${mongodata.month}-${mongodata.day}');
                  deadline = DateTime.parse(
                      "${mongodata.year}-${mongodata.month}-${mongodata.day} 00:00:00");
                  int days = deadline.difference(dateNow).inDays;
                  if (days == 0) {
                    result = '今天過期!';
                    check.add(0);
                  } else if (days < 0) {
                    result = '已經過期 ${-days} 天';
                    check.add(-1);
                  } else {
                    result = '還有 $days 天過期';
                    check.add(1);
                  }
                  dayList.add(result);
                }
                // 有效期限的計算
                return ListView.separated(
                  itemCount: snapshot.data.length,
                  separatorBuilder: (context, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => displayCard(
                    UserMongoDbModel.fromJson(snapshot.data[index]),
                    dayList[index],
                    check[index],
                  ),
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
  Widget displayCard(UserMongoDbModel data, dayList, check) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          height: 81,
          padding: const EdgeInsets.only(left: 32, right: 24, bottom: 16),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor9,
                width: 2,
              ),
              color: check >= 0 ? secondary2 : secondary6,
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
                IconButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              '刪掉的食物要幫您加入購物清單內嗎？',
                              style: TextStyle(
                                fontFamily: chineseFontfamily,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // _insertData(data.title);
                                MongoDatabase.delete(data);
                                setState(() {});
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: secondary3,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: chineseFontfamily,
                                ),
                              ),
                              child: const Text('Nope'),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _insertData(data.title);
                                MongoDatabase.delete(data);
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(
                                primary: secondary6,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: chineseFontfamily,
                                ),
                              ),
                              child: const Text('Yes!'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  icon: const Icon(Icons.delete_rounded),
                ),
                const SizedBox(
                  width: 16,
                ),
                //* 圓形進度條
                // CircularProgressIndicator(
                //   backgroundColor: Colors.grey[200],
                //   valueColor: const AlwaysStoppedAnimation(secondary4),
                //   value: double.parse(data.used) / 100,
                // ),
                // const SizedBox(
                //   width: 24,
                // ),
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
                            Text(
                              data.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: englishFontfamily,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                //* 有效期限：月日
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
                                        bottom: 1.0),
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
                                const SizedBox(
                                  width: 4,
                                ),
                                //* 存放地點
                                Container(
                                  alignment: Alignment.center, // 內裝元件置中對齊
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: secondary4,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                        top: 1.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: Text(
                                        "# ${data.place}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: backgroundColor,
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

  Future<void> _insertData(String title) async {
    var _id = M.ObjectId();
    final data = TobuyModel(
      id: _id,
      uid: user!.uid.toString(),
      title: title,
    );
    var result = await MongoDatabase.toBuyInsert(data)
        .whenComplete(() => Navigator.pop(context));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("匯入成功！"),
      ),
    );
  }
}
