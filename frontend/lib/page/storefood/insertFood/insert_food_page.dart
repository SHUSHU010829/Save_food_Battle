// ignore_for_file: unused_local_variable, unused_element, library_prefixes

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          color: secondary5,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(
                        "Insert Data",
                        style: TextStyle(
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
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: yearController,
                              decoration:
                                  const InputDecoration(labelText: "year"),
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: TextField(
                              controller: monthController,
                              decoration:
                                  const InputDecoration(labelText: "month"),
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: TextField(
                              controller: dayController,
                              decoration:
                                  const InputDecoration(labelText: "day"),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: countController,
                              decoration:
                                  const InputDecoration(labelText: "數量"),
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: TextField(
                              controller: unitController,
                              decoration:
                                  const InputDecoration(labelText: "單位"),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: splaceController,
                              decoration:
                                  const InputDecoration(labelText: "收納地點"),
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: TextField(
                              controller: splaceController,
                              decoration:
                                  const InputDecoration(labelText: "收藏方式"),
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        controller: usedController,
                        decoration: const InputDecoration(labelText: "已使用"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 3,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        _fakeData();
                      },
                      child: const Text("Genrerate"),
                    ),
                    ElevatedButton(
                      onPressed: () {
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
                      },
                      child: const Text('Enter'),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
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
