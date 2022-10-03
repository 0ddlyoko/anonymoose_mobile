import 'package:json_annotation/json_annotation.dart';

part 'tweet.g.dart';

@JsonSerializable(explicitToJson: true)
class Tweet {
  String id;
  String title;
  String text;
  String? parent;
  TweetAuthor author;

  Tweet({
    required this.id,
    required this.title,
    required this.text,
    this.parent,
    required this.author,
  });

  factory Tweet.fromJson(Map<String, dynamic> json) => _$TweetFromJson(json);

  Map<String, dynamic> toJson() => _$TweetToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TweetAuthor {
  String? id;
  String name;
  bool hidden;
  String? picture;

  TweetAuthor({
    this.id,
    required this.name,
    required this.hidden,
    this.picture,
  });

  factory TweetAuthor.fromJson(Map<String, dynamic> json) => _$TweetAuthorFromJson(json);

  Map<String, dynamic> toJson() => _$TweetAuthorToJson(this);
}
