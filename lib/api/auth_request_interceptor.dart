import 'package:dio/dio.dart';


class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.tokenId);

  final String tokenId;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Authorization"] = "Bearer $tokenId";
    handler.next(options);
  }
}
