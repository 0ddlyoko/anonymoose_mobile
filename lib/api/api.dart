import 'package:dio/dio.dart';
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
  final ProfileApi profileApi;
  final TweetApi tweetApi;
  final UserApi userApi;

  NetworkApi(Dio dio, {String baseUrl = apiUrl}):
        profileApi = ProfileApi(dio, baseUrl: baseUrl),
        tweetApi = TweetApi(dio, baseUrl: baseUrl),
        userApi = UserApi(dio, baseUrl: baseUrl);

  @override
  Future<Profile> getProfile() => profileApi.getProfile();

  @override
  Future<Profile> createProfile() => profileApi.createProfile();

  @override
  Future<TweetList> getTweets() => tweetApi.getTweets();

  @override
  Future<Tweet> createTweet(CreateTweet createTweet) => tweetApi.createTweet(createTweet);

  @override
  Future<Tweet> getTweet(String tweetId) => tweetApi.getTweet(tweetId);

  @override
  Future<TweetList> getComments(String tweetId) => tweetApi.getComments(tweetId);

  @override
  Future<Tweet> postComment(String tweetId, CreateTweetAuthor createTweetAuthor) => tweetApi.postComment(tweetId, createTweetAuthor);

  @override
  Future<UserList> getUsers() => userApi.getUsers();

  @override
  Future<User> getUser(String userId) => userApi.getUser(userId);

  @override
  Future<TweetList> getUserTweets(String userId) => userApi.getUserTweets(userId);
}
