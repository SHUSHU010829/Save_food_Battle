import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Goods welcomeFromJson(String str) => Goods.fromJson(json.decode(str));

String welcomeToJson(Goods data) => json.encode(data.toJson());
class Goods{
    Goods({
    required this.id,
    required this.name,
    required this.count,
    required this.cost,
    });
  ObjectId id;
  String name;
  String count;
  String cost;
  factory Goods.fromJson(Map<String, dynamic> json) => Goods(
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
