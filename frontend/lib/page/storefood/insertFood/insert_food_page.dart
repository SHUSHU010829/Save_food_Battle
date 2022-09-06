// ignore_for_file: library_prefixes, unnecessary_null_comparison

import 'dart:math';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/user_allstorefood_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class InsertFoodPage extends StatefulWidget {
  const InsertFoodPage({Key? key}) : super(key: key);

  @override
  State<InsertFoodPage> createState() => _InsertFoodPageState();
}

class _InsertFoodPageState extends State<InsertFoodPage> {
  get mainAxisAlignment => null;

  var titleController = TextEditingController();
  var yearController = TextEditingController();
  var monthController = TextEditingController();
  var dayController = TextEditingController();
  var countController = TextEditingController();
  var unitController = TextEditingController();
  var splaceController = TextEditingController();
  var smethodController = TextEditingController();
  var usedController = TextEditingController();

  var _checkInsertUpdate = "Insert";

  @override
  Widget build(BuildContext context) {
    UserMongoDbModel? data =
        ModalRoute.of(context)!.settings.arguments as UserMongoDbModel?;
    if (data != null) {
      titleController.text = data.title;
      yearController.text = data.year;
      monthController.text = data.month;
      dayController.text = data.day;
      countController.text = data.count;
      unitController.text = data.unit;
      splaceController.text = data.place;
      smethodController.text = data.storeMethod;
      usedController.text = data.used;
      _checkInsertUpdate = "Update";
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor3,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    _checkInsertUpdate,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: chineseFontfamily,
                      color: textColor,
                    ),
                  ),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: "Title"),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: yearController,
                          decoration: const InputDecoration(labelText: "year"),
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: TextField(
                          controller: monthController,
                          decoration: const InputDecoration(labelText: "month"),
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: TextField(
                          controller: dayController,
                          decoration: const InputDecoration(labelText: "day"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: countController,
                    decoration: const InputDecoration(labelText: "數量"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: unitController,
                    decoration: const InputDecoration(labelText: "單位"),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: splaceController,
                          decoration: const InputDecoration(labelText: "收納地點"),
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: TextField(
                          controller: smethodController,
                          decoration: const InputDecoration(labelText: "收藏方式"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: usedController,
                    decoration: const InputDecoration(labelText: "已使用(0-100)"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    _fakeData();
                  },
                  child: const Text("隨機資料"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_checkInsertUpdate == "Update") {
                      _updateData(
                          data?.id,
                          titleController.text,
                          yearController.text,
                          monthController.text,
                          dayController.text,
                          countController.text,
                          unitController.text,
                          splaceController.text,
                          smethodController.text,
                          usedController.text);
                    } else {
                      _insertData(
                          titleController.text,
                          yearController.text,
                          monthController.text,
                          dayController.text,
                          countController.text,
                          unitController.text,
                          splaceController.text,
                          smethodController.text,
                          usedController.text);
                    }
                  },
                  child: Text(_checkInsertUpdate),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _updateData(
      var id,
      String title,
      String year,
      String month,
      String day,
      String count,
      String unit,
      String place,
      String storeMethod,
      String used) async {
    final updateDate = UserMongoDbModel(
        id: id,
        title: title,
        year: year,
        month: month,
        day: day,
        count: count,
        unit: unit,
        place: place,
        storeMethod: storeMethod,
        used: used);
    var result = await MongoDatabase.update(updateDate)
        .whenComplete(() => Navigator.pop(context));
  }

  Future<void> _insertData(
    String title,
    String year,
    String month,
    String day,
    String count,
    String unit,
    String place,
    String storeMethod,
    String used,
  ) async {
    var _id = M.ObjectId(); // store Unique id inside our variable
    final data = UserMongoDbModel(
      id: _id,
      title: title,
      year: year,
      month: month,
      day: day,
      count: count,
      unit: unit,
      place: place,
      storeMethod: storeMethod,
      used: used,
    );
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Inserted ID" + _id.$oid),
      ),
    );
    _clearAll();
  }

  void _clearAll() {
    titleController.text = "";
    yearController.text = "";
    monthController.text = "";
    dayController.text = "";
    countController.text = "";
    unitController.text = "";
    splaceController.text = "";
    smethodController.text = "";
    usedController.text = "";
  }

  void _fakeData() {
    final fakerFa = Faker(provider: FakerDataProvider());
    setState(() {
      titleController.text = fakerFa.lorem.word();
      yearController.text = Random().nextInt(22).toString();
      monthController.text = Random().nextInt(12).toString();
      dayController.text = Random().nextInt(31).toString();
      countController.text = Random().nextInt(10).toString();
      unitController.text = fakerFa.lorem.word();
      splaceController.text = fakerFa.lorem.word();
      smethodController.text = fakerFa.lorem.word();
      usedController.text = Random().nextInt(100).toString();
    });
  }
}
