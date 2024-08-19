import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_and_weather/models/news_model.dart';
import 'package:news_and_weather/models/weather/forecast_model.dart';
import 'package:news_and_weather/models/weather/weather_model.dart';
import 'package:news_and_weather/services/news_api_services.dart';
import 'package:news_and_weather/services/weather_api_services.dart';

final AsyncNotifierProvider<WeatherAsyncNotifier, WeatherModel>
    weatherDataAsyncNotifierProvider =
    AsyncNotifierProvider<WeatherAsyncNotifier, WeatherModel>(
        () => WeatherAsyncNotifier());

class WeatherAsyncNotifier extends AsyncNotifier<WeatherModel> {
  @override
  FutureOr<WeatherModel> build() {
    return _loadWeatherApi();
  }

  Future<WeatherModel> _loadWeatherApi() async {
    final weatherApiResponse = await WeatherApiService.fetchWeatherApi();
    return weatherApiResponse;
  }

  Future<void> reloadWeatherApi() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadWeatherApi());
  }
}

final AutoDisposeFutureProvider<ForeCastModel> forecastDataProvider =
    FutureProvider.autoDispose<ForeCastModel>((
  ref,
) async {
  return await WeatherApiService.fetchForeCastApi();
});

/// News ApI providers
final AutoDisposeFutureProviderFamily<NewsModel, String>
    categoryNewsDataProvider = FutureProvider.autoDispose
        .family<NewsModel, String>((ref, queryState) async {
  return await NewsApiServices.fetchTopNews(query: queryState);
});

final AutoDisposeFutureProvider<NewsModel> filteredNewsDataProvider =
    FutureProvider.autoDispose<NewsModel>((ref) async {
  return await NewsApiServices.fetchTopNews();
});
