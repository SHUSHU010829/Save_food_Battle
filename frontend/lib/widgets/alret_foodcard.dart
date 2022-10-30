// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/alertFood_model.dart';
import 'package:frontend/models/data/tobuy/tobuy_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class AlertFoodCard extends StatefulWidget {
  const AlertFoodCard({Key? key}) : super(key: key);

  @override
  State<AlertFoodCard> createState() => _AlertFoodCardState();
}

class _AlertFoodCardState extends State<AlertFoodCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MediaQuery.removePadding(
          //消除頂部空白
          context: context,
          removeTop: true,
          child: FutureBuilder(
            future: MongoDatabase.getAlertData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  // var totalData = snapshot.data.length;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => displayCard(
                      AlertFoodModel.fromJson(snapshot.data[index]),
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
      ],
    );
  }

  Widget displayCard(AlertFoodModel data) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          height: 60,
          padding: const EdgeInsets.only(left: 4, right: 4, bottom: 12),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor9,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: secondary2,
              boxShadow: const [
                BoxShadow(
                  color: primaryColor2,
                  offset: Offset(6.0, 6.0), //陰影x軸偏移量
                  blurRadius: 8, //陰影模糊程度
                  spreadRadius: 0, //陰影擴散程度
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        print(data.id);
                        MongoDatabase.deleteAlert(data);
                        setState(() {});
                      },
                      icon: const Icon(Icons.delete_rounded),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: englishFontfamily,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    _insertData(data.title);
                    // setState(() {});
                  },
                  icon: const Icon(
                    Icons.add_rounded,
                    size: 32,
                    color: primaryColor4,
                  ),
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
      title: title,
    );
    var result = await MongoDatabase.toBuyInsert(data)
        .whenComplete(() => Navigator.pop(context));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("匯入成功！請刷新表單～"),
      ),
    );
  }
}
