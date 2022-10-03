// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tweet_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _TweetApi implements TweetApi {
  _TweetApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<TweetList> getTweets() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TweetList>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/tweet',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TweetList.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Tweet> createTweet(createTweet) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(createTweet.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Tweet>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, '/tweet',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Tweet.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Tweet> getTweet(tweetId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Tweet>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/tweet/${tweetId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Tweet.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TweetList> getComments(tweetId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TweetList>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/tweet/${tweetId}/comment',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TweetList.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Tweet> postComment(tweetId, createTweetAuthor) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(createTweetAuthor.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Tweet>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/tweet/${tweetId}/comment',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Tweet.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
