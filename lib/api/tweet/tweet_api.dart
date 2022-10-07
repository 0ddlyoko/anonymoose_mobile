import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:mobile/models/tweet/tweet.dart';
import 'package:mobile/models/tweet/tweet_list.dart';
import 'package:mobile/models/tweet/create_tweet.dart';

part 'tweet_api.g.dart';

@RestApi()
abstract class TweetApi {
  factory TweetApi(Dio dio, {String baseUrl}) = _TweetApi;

  @GET("/tweet")
  Future<TweetList> getTweets();

  @POST("/tweet")
  @FormUrlEncoded()
  Future<Tweet> createTweet(@Body() CreateTweet createTweet);

  @GET("/tweet/{tweetId}")
  Future<Tweet> getTweet(@Path() String tweetId);

  @GET("/tweet/{tweetId}/comment")
  Future<TweetList> getComments(@Path() String tweetId);

  @POST("/tweet/{tweetId}/comment")
  Future<Tweet> postComment(@Path() String tweetId, @Body() CreateTweetComment createTweetComment);
}
