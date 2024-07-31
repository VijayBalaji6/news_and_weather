import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_and_weather/constants/app_theme.dart';
import 'package:news_and_weather/provider/theme_notifier.dart';
import 'package:news_and_weather/view/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkThemeTheme = ref.watch(themeProvider);
    return MaterialApp(
      title: 'News And Weather',
      debugShowCheckedModeBanner: false,
      theme: isDarkThemeTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
