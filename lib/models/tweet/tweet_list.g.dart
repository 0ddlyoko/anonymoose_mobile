// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tweet_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TweetList _$TweetListFromJson(Map<String, dynamic> json) => TweetList(
      count: json['count'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => Tweet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TweetListToJson(TweetList instance) => <String, dynamic>{
      'count': instance.count,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
