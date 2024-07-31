import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_and_weather/provider/app_state_provider.dart';
import 'package:news_and_weather/provider/news_choice_provider.dart';
import 'package:news_and_weather/provider/theme_notifier.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final isDarkTheme = ref.watch(themeProvider);
                return switcherWidget(
                  title: "Theme Mode",
                  leftText: 'Light',
                  rightText: 'Dark',
                  switchState: isDarkTheme,
                  switchFunction: (bool value) => ref
                      .read(themeProvider.notifier)
                      .onChangeTheme(darkThemeState: value),
                );
              },
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final temperatureState = ref.watch(temperatureScaleState);
                return switcherWidget(
                    title: "Temperature",
                    leftText: 'Fahrenheit °F',
                    rightText: 'Celsius °C',
                    switchState: temperatureState == TemperatureState.celsius,
                    switchFunction: (bool value) =>
                        ref.read(temperatureScaleState.notifier).state = value
                            ? TemperatureState.celsius
                            : TemperatureState.fahrenheit);
              },
            ),
            const Text('News Choice'),
            Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Column(
                children: [
                  ...newsChoices.map((option) => RadioListTile<String>(
                        title: Text(option),
                        value: option,
                        groupValue: ref.watch(newsChoiceProvider),
                        onChanged: (value) => ref
                            .watch(newsChoiceProvider.notifier)
                            .updateNewsChoice(value ?? option[0]),
                      )),
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  Widget switcherWidget(
      {required String title,
      required String leftText,
      required String rightText,
      required bool switchState,
      required ValueChanged<bool> switchFunction}) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          title,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              leftText,
            ),
            Switch(
              value: switchState,
              onChanged: (bool value) => switchFunction(value),
            ),
            Text(rightText),
          ],
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }
}
