// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_tweet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTweet _$CreateTweetFromJson(Map<String, dynamic> json) => CreateTweet(
      title: json['title'] as String,
      text: json['text'] as String,
      author:
          CreateTweetAuthor.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateTweetToJson(CreateTweet instance) =>
    <String, dynamic>{
      'title': instance.title,
      'text': instance.text,
      'author': instance.author.toJson(),
    };

CreateTweetComment _$CreateTweetCommentFromJson(Map<String, dynamic> json) =>
    CreateTweetComment(
      title: json['title'],
      text: json['text'],
      author: json['author'],
      parent: json['parent'] as String?,
    );

Map<String, dynamic> _$CreateTweetCommentToJson(CreateTweetComment instance) =>
    <String, dynamic>{
      'title': instance.title,
      'text': instance.text,
      'author': instance.author.toJson(),
      'parent': instance.parent,
    };

CreateTweetAuthor _$CreateTweetAuthorFromJson(Map<String, dynamic> json) =>
    CreateTweetAuthor(
      hidden: json['hidden'] as bool,
    );

Map<String, dynamic> _$CreateTweetAuthorToJson(CreateTweetAuthor instance) =>
    <String, dynamic>{
      'hidden': instance.hidden,
    };
