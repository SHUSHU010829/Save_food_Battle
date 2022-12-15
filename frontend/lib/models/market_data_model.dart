import 'dart:convert';

MarketData welcomeFromJson(String str) => MarketData.fromJson(json.decode(str));

String welcomeToJson(MarketData data) => json.encode(data.toJson());

class MarketData {
  MarketData({
    required this.name,
    required this.date,
    required this.temperature,
  });

  String name;
  String date;
  String temperature;

  /// Convert from JSON response stream to Favorite object
  factory MarketData.fromJson(Map<String, dynamic> parsedJson) {
    return MarketData(
        name: parsedJson['name'],
        date: parsedJson['date'],
        temperature: parsedJson['temperature']);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "date": date,
        "temperature": temperature,
      };
}
