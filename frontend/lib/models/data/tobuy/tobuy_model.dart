// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

TobuyModel welcomeFromJson(String str) => TobuyModel.fromJson(json.decode(str));

String welcomeToJson(TobuyModel data) => json.encode(data.toJson());

class TobuyModel {
  TobuyModel({
    required this.id,
    required this.title,
  });

  ObjectId id;
  String title;

  factory TobuyModel.fromJson(Map<String, dynamic> json) => TobuyModel(
        id: json["_id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
      };
}
