import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mobile/models/profile/profile.dart';
import 'package:mobile/models/tweet/create_tweet.dart';
import 'package:mobile/models/tweet/tweet.dart';
import 'package:mobile/models/tweet/tweet_list.dart';
import 'package:mobile/models/user/user.dart';
import 'package:mobile/models/user/user_list.dart';

import '../constants.dart';
import 'profile/profile_api.dart';
import 'tweet/tweet_api.dart';
import 'user/user_api.dart';

class NetworkApi implements ProfileApi, TweetApi, UserApi {
  final Dio dio;
  final ProfileApi profileApi;
  final TweetApi tweetApi;
  final UserApi userApi;

  NetworkApi(this.dio, {String baseUrl = apiUrl}):
        profileApi = ProfileApi(dio, baseUrl: baseUrl),
        tweetApi = TweetApi(dio, baseUrl: baseUrl),
        userApi = UserApi(dio, baseUrl: baseUrl);

  @override
  Future<HttpResponse<Profile>> getProfile() => profileApi.getProfile();

  @override
  Future<HttpResponse<Profile>> createProfile() => profileApi.createProfile();

  @override
  Future<HttpResponse<TweetList>> getTweets() => tweetApi.getTweets();

  @override
  Future<HttpResponse<Tweet>> createTweet(CreateTweet createTweet) => tweetApi.createTweet(createTweet);

  @override
  Future<HttpResponse<Tweet>> getTweet(String tweetId) => tweetApi.getTweet(tweetId);

  @override
  Future<HttpResponse<TweetList>> getComments(String tweetId) => tweetApi.getComments(tweetId);

  @override
  Future<HttpResponse<Tweet>> postComment(String tweetId, CreateTweetComment createTweetComment) => tweetApi.postComment(tweetId, createTweetComment);

  @override
  Future<HttpResponse<UserList>> getUsers() => userApi.getUsers();

  @override
  Future<HttpResponse<User>> getUser(String userId) => userApi.getUser(userId);

  @override
  Future<HttpResponse<TweetList>> getUserTweets(String userId) => userApi.getUserTweets(userId);
}
