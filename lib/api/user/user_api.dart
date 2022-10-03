import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:mobile/models/tweet/tweet_list.dart';
import 'package:mobile/models/user/user.dart';
import 'package:mobile/models/user/user_list.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET("/user")
  Future<UserList> getUsers();

  @GET("/user/{userId}")
  Future<User> getUser(@Path("userId") String userId);

  @GET("/user/{userId}/tweet")
  Future<TweetList> getUserTweets(@Path("userId") String userId);
}
