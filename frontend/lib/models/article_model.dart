import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';  // 這個檔案的程式碼是 User 定義的一部份，它稍後才會建構產生

@JsonSerializable(createToJson: false)  // 標註這個類別中的程式碼要自動產生
class Article {
  // 標註 API 的 key 與欄位名稱的對應
  @JsonKey(defaultValue: 'UnKnown')
  final String author;
  final String? title;
  final String? description;
  final String? url;
  @JsonKey(name: 'urlToImage')
  final String? imageUrl;
  final String? publishedAt;
  final String? content;
  final ArticleSource source;

  Article(
      {required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.imageUrl,
      required this.publishedAt,
      required this.content,
      required this.source});

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}

@JsonSerializable(createToJson: false)
class ArticleSource {
  final String? id;
  final String? name;

  ArticleSource({required this.id, required this.name});

  factory ArticleSource.fromJson(Map<String, dynamic> json) =>
      _$ArticleSourceFromJson(json);
}
