import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

AlertFoodModel welcomeFromJson(String str) =>
    AlertFoodModel.fromJson(json.decode(str));

String welcomeToJson(AlertFoodModel data) => json.encode(data.toJson());

class AlertFoodModel {
  AlertFoodModel({
    required this.id,
    required this.uid,
    required this.title,
  });

  ObjectId id;
  String uid;
  String title;

  factory AlertFoodModel.fromJson(Map<String, dynamic> json) => AlertFoodModel(
        id: json["_id"],
        uid: json["uid"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "title": title,
      };
}
