// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/dbHelper/user/constant.dart';
import 'package:frontend/models/alertFood_model.dart';
import 'package:frontend/models/data/tobuy/tobuy_model.dart';
import 'package:frontend/models/user_allstorefood_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  //* 串資料庫
  static var db, userCollection, tobuyCollection, alertCollection;
  var user = FirebaseAuth.instance.currentUser!;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
    tobuyCollection = db.collection(TOBUY_COLLECTION);
    alertCollection = db.collection(ALERT_COLLECTION);
  }

  //* 新增購物清單食材
  static Future<String> toBuyInsert(TobuyModel data) async {
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

  //* Display Data : Tobuy
  Future<List<Map<String, dynamic>>?> getTobuyData() async {
    try {
      final arrData = await tobuyCollection.find({'uid': user.uid}).toList();
      return arrData;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  //* Delete Data : Tobuy
  static deleteTobuy(TobuyModel data) async {
    await tobuyCollection.remove(where.id(data.id));
  }

  //* Display Data : Alert
  static Future<List<Map<String, dynamic>>> getAlertData() async {
    final arrData = await alertCollection.find(where.sortBy('title')).toList();
    return arrData;
  }

  //* Delete Data : Alert
  static deleteAlert(AlertFoodModel data) async {
    await alertCollection.remove(where.id(data.id));
  }

  //* 日期紀錄
  DateTime dateNow = DateTime.now();
  DateTime deadline = DateTime.parse("2022-10-11 00:00:00");

  //* Display Data : 全部食物卡
  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find(where.sortBy('title')).toList();
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
