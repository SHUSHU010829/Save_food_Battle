import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

ScanQrModel welcomeFromJson(String str) =>
    ScanQrModel.fromJson(json.decode(str));

String welcomeToJson(ScanQrModel data) => json.encode(data.toJson());

class ScanQrModel {
  ScanQrModel({
    required this.id,
    required this.name,
    required this.count,
    required this.cost,
  });

  ObjectId id;
  String name;
  String count;
  String cost;

  factory ScanQrModel.fromJson(Map<String, dynamic> json) => ScanQrModel(
        id: json["_id"],
        name: json["name"],
        count: json["count"],
        cost: json["cost"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "count": count,
        "cost": cost,
      };
}
