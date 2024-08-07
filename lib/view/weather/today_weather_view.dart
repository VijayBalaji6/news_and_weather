import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_and_weather/models/weather/weather_model.dart';
import 'package:news_and_weather/provider/app_state_provider.dart';
import 'package:news_and_weather/provider/weather_data_provider.dart';
import 'package:news_and_weather/services/common_services.dart';

class WeatherView extends ConsumerWidget {
  const WeatherView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsyncData = ref.watch(todayWeatherProvider);
    final bool isCelsiusScale =
        ref.watch(temperatureScaleState) == TemperatureState.celsius;

    return RefreshIndicator.adaptive(
      onRefresh: () async {
        ref.read(todayWeatherProvider.notifier).refresh();
      },
      child: weatherAsyncData.when(
        data: (WeatherModel value) {
          return Scrollbar(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        value.name ?? "",
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildWeatherCard(value, isCelsiusScale),
                    const SizedBox(height: 20),
                    _buildDetailsCard(value, isCelsiusScale),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildWeatherCard(WeatherModel weather, bool isCelsiusScale) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weather.weather?[0].main ?? "",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  weather.weather?[0].description ?? "",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Text(
                  CommonServices.convertKelvinToTemp(
                      kelvin: weather.main!.temp!, toCelsius: isCelsiusScale),
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(weather, bool isCelsiusScale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1,
          ),
          children: [
            _buildDetailRow(
                'Feels Like',
                CommonServices.convertKelvinToTemp(
                    kelvin: weather.main!.feelsLike!,
                    toCelsius: isCelsiusScale)),
            _buildDetailRow(
                'Min Temp',
                CommonServices.convertKelvinToTemp(
                    kelvin: weather.main!.tempMin!, toCelsius: isCelsiusScale)),
            _buildDetailRow(
                'Max Temp',
                CommonServices.convertKelvinToTemp(
                    kelvin: weather.main!.tempMax!, toCelsius: isCelsiusScale)),
            _buildDetailRow('Pressure', '${weather.main?.pressure} hPa'),
            _buildDetailRow('Humidity', '${weather.main?.humidity}%'),
            _buildDetailRow('Wind Speed', '${weather.main?.humidity} m/s'),
            _buildDetailRow('Wind Gust', '${weather.main?.humidity} m/s'),
          ],
        )
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
