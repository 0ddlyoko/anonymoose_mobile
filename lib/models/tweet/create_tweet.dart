import 'package:json_annotation/json_annotation.dart';

part 'create_tweet.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateTweet {
  String title;
  String text;
  CreateTweetAuthor author;

  CreateTweet({
    required this.title,
    required this.text,
    required this.author,
  });

  factory CreateTweet.fromJson(Map<String, dynamic> json) => _$CreateTweetFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTweetToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateTweetComment extends CreateTweet {
  String? parent;

  CreateTweetComment({
    required title,
    required text,
    required author,
    this.parent,
  }): super(title: title, text: text, author: author);

  factory CreateTweetComment.fromJson(Map<String, dynamic> json) => _$CreateTweetCommentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateTweetCommentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateTweetAuthor {
  bool hidden;

  CreateTweetAuthor({
    required this.hidden,
  });

  factory CreateTweetAuthor.fromJson(Map<String, dynamic> json) => _$CreateTweetAuthorFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTweetAuthorToJson(this);
}
