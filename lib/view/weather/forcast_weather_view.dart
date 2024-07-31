import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_and_weather/models/weather/forecast_model.dart';
import 'package:news_and_weather/provider/app_state_provider.dart';
import 'package:news_and_weather/provider/future_provider.dart';
import 'package:news_and_weather/services/common_services.dart';

class ForecastWeatherView extends ConsumerWidget {
  const ForecastWeatherView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ForeCastModel> forecastAsyncData =
        ref.watch(forecastDataProvider);
    final bool isCelsiusScale =
        ref.watch(temperatureScaleState) == TemperatureState.celsius;

    switch (forecastAsyncData) {
      case AsyncError(:final error):
        return Center(child: Text('Error: $error'));

      case AsyncData(:final ForeCastModel value):
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: value.list.length,
            itemBuilder: (context, index) {
              final element = value.list[index].main;
              return Column(
                children: [
                  Center(
                    child: Text(
                      DateFormat('yyyy-MM-dd h:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              value.list[index].dt * 1000)),
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1,
                    ),
                    children: [
                      _buildDetail(
                          'Feels Like',
                          CommonServices.convertKelvinToTemp(
                              kelvin: element.tempMax,
                              toCelsius: isCelsiusScale)),
                      _buildDetail(
                          'Min Temp',
                          CommonServices.convertKelvinToTemp(
                              kelvin: element.tempMax,
                              toCelsius: isCelsiusScale)),
                      _buildDetail(
                          'Max Temp',
                          CommonServices.convertKelvinToTemp(
                              kelvin: element.tempMax,
                              toCelsius: isCelsiusScale)),
                      _buildDetail('Pressure', '${element.pressure} hPa'),
                      _buildDetail('Humidity', '${element.humidity}%'),
                      _buildDetail('Wind Speed', '${element.humidity} m/s'),
                      _buildDetail('Wind Gust', '${element.humidity} m/s'),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}

Widget _buildDetail(String label, String value) {
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
