import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_and_weather/constants/api_constants.dart';
import 'package:news_and_weather/models/weather/forecast_model.dart';
import 'package:news_and_weather/models/weather/weather_model.dart';
import 'package:news_and_weather/services/location_services.dart';

class WeatherApiService {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: ApiConstants.weatherBaseURL,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  static Future<WeatherModel> fetchWeatherApi() async {
    try {
      final userLocation = await LocationServices.instance.getUserLocation();

      Response response =
          await dio.get(ApiConstants.currentWeatherUrl, queryParameters: {
        'appid': ApiConstants.weatherApiKey,
        'lat': userLocation.latitude,
        'lon': userLocation.longitude,
      });

      switch (response.statusCode) {
        case 200:
          return WeatherModel.fromJson(response.data);
        default:
          throw Exception('error');
      }
    } on SocketException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ForeCastModel> fetchForeCastApi() async {
    try {
      Response response = await dio.get(ApiConstants.forecastWeatherUrl,
          queryParameters: {'appid': ApiConstants.weatherApiKey, 'id': 524901});

      switch (response.statusCode) {
        case 200:
          return ForeCastModel.fromJson(response.data);
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
