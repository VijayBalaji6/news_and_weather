import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TemperatureState {
  celsius,
  fahrenheit,
}

final temperatureScaleState =
    StateProvider<TemperatureState>((ref) => TemperatureState.celsius);
