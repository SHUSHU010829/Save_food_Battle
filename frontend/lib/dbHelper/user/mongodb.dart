// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:developer';

import 'package:frontend/dbHelper/user/constant.dart';
import 'package:frontend/models/user_allstorefood_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  //* Display Data
  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  //* Update Data
  static Future<void> update(UserMongoDbModel data) async {
    var result = await userCollection.findOne({"_id": data.id});
    result['title'] = data.title;
    result['year'] = data.year;
    result['month'] = data.month;
    result['day'] = data.day;
    result['count'] = data.count;
    result['unit'] = data.unit;
    result['place'] = data.place;
    result['storeMethod'] = data.storeMethod;
    result['used'] = data.used;
    var response = await userCollection.save(result);
    inspect(response);
  }

  //* Insert Data
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
