// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tweet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tweet _$TweetFromJson(Map<String, dynamic> json) => Tweet(
      id: json['id'] as String,
      title: json['title'] as String,
      text: json['text'] as String,
      parent: json['parent'] as String?,
      author: TweetAuthor.fromJson(json['author'] as Map<String, dynamic>),
      comments: json['comments'] == null
          ? null
          : TweetComments.fromJson(json['comments'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TweetToJson(Tweet instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'parent': instance.parent,
      'author': instance.author.toJson(),
      'comments': instance.comments?.toJson(),
    };

TweetAuthor _$TweetAuthorFromJson(Map<String, dynamic> json) => TweetAuthor(
      id: json['id'] as String?,
      name: json['name'] as String,
      hidden: json['hidden'] as bool,
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$TweetAuthorToJson(TweetAuthor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hidden': instance.hidden,
      'picture': instance.picture,
    };

TweetComments _$TweetCommentsFromJson(Map<String, dynamic> json) =>
    TweetComments(
      size: json['size'] as int,
    );

Map<String, dynamic> _$TweetCommentsToJson(TweetComments instance) =>
    <String, dynamic>{
      'size': instance.size,
    };
