// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/dbModel/tobuy_model.dart';
import 'package:frontend/theme/constants.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/dbModel/user_allstorefood_model.dart';
import 'package:frontend/page/storefood/insert_page.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:flutter_slidable/flutter_slidable.dart';

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
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
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
                    if (totalData == 0) {
                      return const Center(
                        child: Text("目前倉庫沒任何食物喔！"),
                      );
                    }
                    dayList.clear();
                    check.clear();
                    for (int i = 0; i < totalData; i++) {
                      var mongodata =
                          UserMongoDbModel.fromJson(snapshot.data[i]);
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
                      separatorBuilder: (context, _) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) => displayCard(
                        UserMongoDbModel.fromJson(snapshot.data[index]),
                        dayList[index],
                        check[index],
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("重整連接資料庫！"),
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  //* 全部食物卡片區
  Widget displayCard(UserMongoDbModel data, dayList, check) => Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: ((context) {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
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
                                  horizontal: 48, vertical: 8),
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
                                  horizontal: 48, vertical: 8),
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
                );
              }),
              backgroundColor: const Color(0xffe86159),
              icon: Icons.delete_rounded,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: ((context) {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) {
                              // return const InsertFoodPage();
                              return const InsertPage();
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
              color: secondary3,
              width: 2,
            ),
            color: check >= 0 ? secondary7 : secondary8,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 16.0),
                child: Row(
                  children: [
                    //* 圓形進度條
                    CircularProgressIndicator(
                      backgroundColor: white1,
                      valueColor: const AlwaysStoppedAnimation(green1),
                      value: double.parse(data.used) / 100,
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            //* title
                            Text(
                              data.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: chineseFontfamily,
                              ),
                            ),
                            //* used
                            Container(
                              alignment: Alignment.center, // 內裝元件置中對齊
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0,
                                    right: 10.0,
                                    top: 1.0,
                                    bottom: 2.0),
                                child: Center(
                                  child: Text(
                                    "${data.used}%",
                                    style: const TextStyle(
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
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            //* 有效期限：月日
                            Container(
                              alignment: Alignment.center, // 內裝元件置中對齊
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: check >= 0 ? secondary8 : secondary7,
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
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Future<void> _handleRefresh() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    setState(() {});
  }

  Future<void> _insertData(String title) async {
    var _id = M.ObjectId();
    final data = TobuyModel(
      id: _id,
      uid: user.uid.toString(),
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
