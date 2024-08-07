import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_and_weather/models/weather/weather_model.dart';
import 'package:news_and_weather/services/weather_api_services.dart';

class TodayWeatherNotifier extends StateNotifier<AsyncValue<WeatherModel>> {
  TodayWeatherNotifier() : super(const AsyncValue.loading()) {
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      state = const AsyncValue.loading();
      final data = await WeatherApiService.fetchWeatherApi();
      state = AsyncValue.data(data);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void refresh() => _fetchWeatherData();
}

final todayWeatherProvider =
    StateNotifierProvider<TodayWeatherNotifier, AsyncValue<WeatherModel>>(
  (ref) => TodayWeatherNotifier(),
);
