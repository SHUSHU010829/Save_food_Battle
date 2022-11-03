// ignore_for_file: library_prefixes, unnecessary_null_comparison, unused_local_variable, avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  // var unitController = TextEditingController();
  var splaceController = TextEditingController();
  var smethodController = TextEditingController();
  var usedController = TextEditingController();

  var _checkInsertUpdate = "Insert";

  DateTime _dateTime = DateTime.now();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserMongoDbModel? data =
        ModalRoute.of(context)!.settings.arguments as UserMongoDbModel?;
    if (data != null) {
      titleController.text = data.title;
      countController.text = data.count;
      // unitController.text = data.unit;
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
        centerTitle: true,
        title: Text(
          _checkInsertUpdate,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            fontFamily: chineseFontfamily,
            color: secondary2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      // 商品名
                      TextFormField(
                        controller: titleController,
                        maxLines: null,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: secondary6),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: secondary6),
                          ),
                          prefixIcon: Icon(
                            Icons.title_rounded,
                            color: secondary6,
                          ),
                          hintText: "食物品項名",
                          hintStyle: TextStyle(
                            color: secondary3,
                            fontWeight: FontWeight.w700,
                            fontFamily: chineseFontfamily,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Empty!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      // 日期選擇
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const SizedBox(width: 11),
                                const Icon(
                                  Icons.schedule_rounded,
                                  color: secondary6,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "有效日期",
                                  style: TextStyle(
                                    color: secondary3,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: chineseFontfamily,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: secondary6,
                                  ),
                                  onPressed: () async {
                                    DateTime? _newDate = await showDatePicker(
                                      context: context,
                                      initialDate: _dateTime,
                                      firstDate: DateTime(DateTime.now().year),
                                      lastDate:
                                          DateTime(DateTime.now().year + 10),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: const ColorScheme(
                                              // uses the brightness of the user (Light or Dark)
                                              brightness: Brightness.light,
                                              primary: primaryColor7,
                                              onPrimary: primaryColor1,
                                              secondary: secondary1,
                                              onSecondary: secondary1,
                                              error: secondary6,
                                              onError: secondary1,
                                              background: primaryColor1,
                                              onBackground: primaryColor1,
                                              surface: secondary1,
                                              onSurface: secondary4,
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                primary: secondary6,
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (_newDate != null) {
                                      setState(() {
                                        _dateTime = _newDate;
                                      });
                                    }
                                  },
                                  child: Text(
                                    '${_dateTime.year}-${_dateTime.month}-${_dateTime.day}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // 數量
                      TextFormField(
                        controller: countController,
                        maxLines: null,
                        keyboardType:
                            defaultTargetPlatform == TargetPlatform.iOS
                                ? const TextInputType.numberWithOptions(
                                    decimal: true, signed: true)
                                : TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: secondary6),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: secondary6),
                          ),
                          prefixIcon: Icon(
                            Icons.numbers_rounded,
                            color: secondary6,
                          ),
                          hintText: "數量",
                          hintStyle: TextStyle(
                            color: secondary3,
                            fontWeight: FontWeight.w700,
                            fontFamily: chineseFontfamily,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Empty!";
                          } else if (int.parse(value) <= 0) {
                            return "Error Range! Pleace input more than 0";
                          } else {
                            return null;
                          }
                        },
                      ),
                      // const SizedBox(height: 10),
                      // TextField(
                      //   controller: unitController,
                      //   decoration: const InputDecoration(labelText: "單位"),
                      // ),
                      const SizedBox(height: 30),
                      // 收納地點＋收藏方式
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: splaceController,
                              maxLines: null,
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: secondary6),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: secondary6),
                                ),
                                prefixIcon: Icon(
                                  Icons.kitchen_rounded,
                                  color: secondary6,
                                ),
                                hintText: "收納地點",
                                hintStyle: TextStyle(
                                  color: secondary3,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: chineseFontfamily,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Empty!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: smethodController,
                              maxLines: null,
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: secondary6),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: secondary6),
                                ),
                                prefixIcon: Icon(
                                  Icons.device_thermostat_rounded,
                                  color: secondary6,
                                ),
                                hintText: "收藏方式",
                                hintStyle: TextStyle(
                                  color: secondary3,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: chineseFontfamily,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Empty!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // 已使用百分比
                      TextFormField(
                        controller: usedController,
                        keyboardType:
                            defaultTargetPlatform == TargetPlatform.iOS
                                ? const TextInputType.numberWithOptions(
                                    decimal: true, signed: true)
                                : TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: secondary6),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: secondary6),
                          ),
                          prefixIcon: Icon(
                            Icons.percent_rounded,
                            color: secondary6,
                          ),
                          hintText: "已使用百分比(0-100)",
                          hintStyle: TextStyle(
                            color: secondary3,
                            fontWeight: FontWeight.w700,
                            fontFamily: chineseFontfamily,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Empty!";
                          } else if (int.parse(value) > 100 ||
                              int.parse(value) < 0) {
                            return "Error Range! Pleace input 0 - 100";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                // 送出按鈕
                // ignore: todo
                //TODO 在確認資料後跳出視窗詢問繼續輸入或是返回
                ElevatedButton(
                  onPressed: () {
                    final isValidForm = formKey.currentState!.validate();
                    String d, m;
                    if (isValidForm) {
                      if (_dateTime.day < 10 && _dateTime.day > 0) {
                        d = '0${_dateTime.day}';
                      } else {
                        d = '${_dateTime.day}';
                      }
                      if (_dateTime.month < 10 && _dateTime.month > 0) {
                        m = '0${_dateTime.month}';
                      } else {
                        m = '${_dateTime.month}';
                      }
                      if (_checkInsertUpdate == "Update") {
                        _updateData(
                          data?.id,
                          titleController.text.trim(),
                          _dateTime.year.toString(),
                          m,
                          d,
                          countController.text.trim(),
                          // unitController.text,
                          splaceController.text.trim(),
                          smethodController.text.trim(),
                          usedController.text.trim(),
                        );
                      } else {
                        _insertData(
                          titleController.text.trim(),
                          _dateTime.year.toString(),
                          m,
                          d,
                          countController.text.trim(),
                          // unitController.text,
                          splaceController.text.trim(),
                          smethodController.text.trim(),
                          usedController.text.trim(),
                        );
                      }
                    }
                  },
                  child: Text(_checkInsertUpdate),
                  style: ElevatedButton.styleFrom(
                    primary: secondary6,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: secondary3,
                      fontWeight: FontWeight.w700,
                      fontFamily: chineseFontfamily,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
      // String unit,
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
        // unit: unit,
        place: place,
        storeMethod: storeMethod,
        used: used);
    var result = await MongoDatabase.update(updateDate)
        .whenComplete(() => Navigator.pop(context));
    ScaffoldMessenger.of(context).showSnackBar(
      // SnackBar(
      //   content: Text("Inserted ID" + _id.$oid),
      // ),
      const SnackBar(
        content: Text("更新成功！"),
      ),
    );
  }

  Future<void> _insertData(
    String title,
    String year,
    String month,
    String day,
    String count,
    // String unit,
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
      // unit: unit,
      place: place,
      storeMethod: storeMethod,
      used: used,
    );
    var result = await MongoDatabase.insert(data)
        .whenComplete(() => Navigator.pop(context));
    ScaffoldMessenger.of(context).showSnackBar(
      // SnackBar(
      //   content: Text("Inserted ID" + _id.$oid),
      // ),
      const SnackBar(
        content: Text("匯入成功！"),
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
    // unitController.text = "";
    splaceController.text = "";
    smethodController.text = "";
    usedController.text = "";
  }
}
