import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_and_weather/constants/api_constants.dart';
import 'package:news_and_weather/models/news_model.dart';

enum NewsQuery { winning, happiness }

class NewsApiServices {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: NewsApiConstants.newsBaseURL,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  static Future<NewsModel> fetchTopNews({String? query}) async {
    try {
      Map<String, dynamic> apiQuery = {
        'apiKey': NewsApiConstants.newsApiKey,
        'sources': 'techcrunch,bbc-news,the-verge',
      };
      if (query != null) {
        apiQuery['q'] = query;
      }

      Response response = await dio.get(NewsApiConstants.newsHeadlineUrl,
          queryParameters: apiQuery);

      switch (response.statusCode) {
        case 200:
          return NewsModel.fromJson(response.data);
        default:
          throw Exception('error');
      }
    } on SocketException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
