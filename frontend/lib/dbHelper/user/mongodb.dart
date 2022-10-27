// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:developer';

import 'package:frontend/dbHelper/user/constant.dart';
import 'package:frontend/models/user_allstorefood_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  //* 串資料庫
  static var db, userCollection, tobuyCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
    tobuyCollection = db.collection(TOBUY_COLLECTION);
  }

  //* 新增購物清單食材
    static Future<String> toBuyInsert(UserMongoDbModel data) async {
    try {
      var result = await tobuyCollection.insert(data.toJson());
      if (result.isSuccess()) {
        return "Data Inserted";
      } else {
        return "Something wrong while inserting data.";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }


  //* 日期紀錄
  DateTime dateNow = DateTime.now();
  DateTime deadline = DateTime.parse("2022-10-11 00:00:00");

  //* Display Data : 全部食物卡
  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find(where.sortBy('title')).toList();
    return arrData;
  }

  //* Display Data : 首頁食物通知
  static Future<List<Map<String, dynamic>>> getAlertData() async {
    final arrData = await userCollection
        .find(where.sortBy('year'))
        .find(where.sortBy('month'))
        .find(where.sortBy('day')).toList();
    return arrData;
  }

  //* Delete Data : 全部食物卡
  static delete(UserMongoDbModel data) async {
    await userCollection.remove(where.id(data.id));
  }

  //* Query Data : 全部食物卡
  static Future<List<Map<String, dynamic>>> getQueryData(String word) async {
    // ignore: todo
    //TODO 更改成 full-text search
    final data = await userCollection.find({'title': word}).toList();
    return data;
  }

  //* Update Data : 全部食物卡
  static Future<void> update(UserMongoDbModel data) async {
    var result = await userCollection.findOne({"_id": data.id});
    result['title'] = data.title;
    result['year'] = data.year;
    result['month'] = data.month;
    result['day'] = data.day;
    result['count'] = data.count;
    // result['unit'] = data.unit;
    result['place'] = data.place;
    result['storeMethod'] = data.storeMethod;
    result['used'] = data.used;
    var response = await userCollection.save(result);
    inspect(response);
  }

  //* Insert Data : 全部食物卡
  static Future<String> insert(UserMongoDbModel data) async {
    try {
      var result = await userCollection.insert(data.toJson());
      if (result.isSuccess()) {
        return "Data Inserted";
      } else {
        return "Something wrong while inserting data.";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
