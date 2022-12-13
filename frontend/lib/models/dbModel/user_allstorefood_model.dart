// // To parse this JSON data, do
// //
// //     final userMongoDbModel = userMongoDbModelFromJson(jsonString);

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

UserMongoDbModel userMongoDbModelFromJson(String str) =>
    UserMongoDbModel.fromJson(json.decode(str));

String userMongoDbModelToJson(UserMongoDbModel data) =>
    json.encode(data.toJson());

class UserMongoDbModel {
  UserMongoDbModel({
    required this.id,
    required this.uid,
    required this.title,
    required this.year,
    required this.month,
    required this.day,
    required this.count,
    // required this.unit,
    required this.place,
    required this.foodType,
    // required this.type,
    required this.used,
  });

  ObjectId id;
  String uid;
  String title;
  String year;
  String month;
  String day;
  String count;
  // String unit;
  String place;
  String foodType;
  // String type;
  String used;

  factory UserMongoDbModel.fromJson(Map<String, dynamic> json) =>
      UserMongoDbModel(
        id: json["_id"],
        uid: json["uid"],
        title: json["title"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
        count: json["count"],
        // unit: json["unit"],
        place: json["place"],
        foodType: json["foodType"],
        // type: json["type"],
        used: json["used"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "title": title,
        "year": year,
        "month": month,
        "day": day,
        "count": count,
        // "unit": unit,
        "place": place,
        "foodType": foodType,
        // "type": type,
        "used": used,
      };
}
