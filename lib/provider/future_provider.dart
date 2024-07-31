import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_and_weather/models/news_model.dart';
import 'package:news_and_weather/models/weather/forecast_model.dart';
import 'package:news_and_weather/models/weather/weather_model.dart';
import 'package:news_and_weather/services/news_api_services.dart';
import 'package:news_and_weather/services/weather_api_services.dart';

final AutoDisposeFutureProvider<WeatherModel> weatherDataProvider =
    FutureProvider.autoDispose<WeatherModel>((
  ref,
) async {
  return await WeatherApiService.fetchWeatherApi();
});

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

final AutoDisposeFutureProviderFamily<NewsModel, String>
    filteredNewsDataProvider = FutureProvider.autoDispose
        .family<NewsModel, String>((ref, queryState) async {
  return await NewsApiServices.fetchTopNews(query: queryState);
});
