import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:mobile/models/profile/profile.dart';

part 'profile_api.g.dart';

@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio dio, {String baseUrl}) = _ProfileApi;

  @GET("/profile")
  Future<HttpResponse<Profile>> getProfile();

  @POST("/profile")
  @FormUrlEncoded()
  Future<HttpResponse<Profile>> createProfile();
}
