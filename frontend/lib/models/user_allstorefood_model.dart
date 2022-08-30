// To parse this JSON data, do
//
//     final userMongoDbModel = userMongoDbModelFromJson(jsonString);

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

UserMongoDbModel userMongoDbModelFromJson(String str) =>
    UserMongoDbModel.fromJson(json.decode(str));

String userMongoDbModelToJson(UserMongoDbModel data) =>
    json.encode(data.toJson());

class UserMongoDbModel {
  UserMongoDbModel({
    required this.id,
    required this.title,
    required this.urlImage,
    required this.year,
    required this.month,
    required this.day,
    required this.count,
    required this.unit,
    required this.place,
    required this.storeMethod,
    required this.used,
  });

  ObjectId id;
  String title;
  String urlImage;
  String year;
  String month;
  String day;
  int count;
  String unit;
  String place;
  String storeMethod;
  int used;

  factory UserMongoDbModel.fromJson(Map<String, dynamic> json) =>
      UserMongoDbModel(
        id: json["_id"],
        title: json["title"],
        urlImage: json["urlImage"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
        count: json["count"],
        unit: json["unit"],
        place: json["place"],
        storeMethod: json["storeMethod"],
        used: json["used"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "urlImage": urlImage,
        "year": year,
        "month": month,
        "day": day,
        "count": count,
        "unit": unit,
        "place": place,
        "storeMethod": storeMethod,
        "used": used,
      };
}
