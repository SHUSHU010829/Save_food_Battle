import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

ScanQrModel welcomeFromJson(String str) =>
    ScanQrModel.fromJson(json.decode(str));

String welcomeToJson(ScanQrModel data) => json.encode(data.toJson());

class ScanQrModel {
  ScanQrModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.count,
    required this.cost,
  });

  ObjectId id;
  String uid;
  String name;
  String count;
  String cost;

  factory ScanQrModel.fromJson(Map<String, dynamic> json) => ScanQrModel(
        id: json["_id"],
        uid: json["uid"],
        name: json["name"],
        count: json["count"],
        cost: json["cost"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "name": name,
        "count": count,
        "cost": cost,
      };
}
