import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_and_weather/provider/nav_notifier.dart';
import 'package:news_and_weather/view/news/news_screen.dart';
import 'package:news_and_weather/view/settings_screen.dart';
import 'package:news_and_weather/view/weather/weather_screen.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final List<Widget> screens = [
    const WeatherScreen(),
    const NewsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSelectedNavScreen = ref.watch(currentNavScreenProvider);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal, actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SettingsScreen())),
        ),
      ]),
      body: screens[currentSelectedNavScreen],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value) => ref
            .read(currentNavScreenProvider.notifier)
            .onChangeNavView(selectedTabView: value),
        currentIndex: currentSelectedNavScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Weather'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
        ],
      ),
    );
  }
}
