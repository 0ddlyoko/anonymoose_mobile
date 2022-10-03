import 'package:json_annotation/json_annotation.dart';
import 'tweet.dart';

part 'tweet_list.g.dart';

@JsonSerializable(explicitToJson: true)
class TweetList {
  int count;
  List<Tweet> items;

  TweetList({
    required this.count,
    required this.items,
  });

  factory TweetList.fromJson(Map<String, dynamic> json) => _$TweetListFromJson(json);

  Map<String, dynamic> toJson() => _$TweetListToJson(this);
}
