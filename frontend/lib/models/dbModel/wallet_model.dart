// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

WalletModel welcomeFromJson(String str) =>
    WalletModel.fromJson(json.decode(str));

String welcomeToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  WalletModel({
    required this.id,
    required this.uid,
    required this.pay,
  });

  ObjectId id;
  String uid;
  String pay;

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        id: json["_id"],
        uid: json["uid"],
        pay: json["pay"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "pay": pay,
      };
}
