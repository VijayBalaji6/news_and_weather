import 'package:flutter/material.dart';
import 'package:news_and_weather/constants/app_colors.dart';
import 'package:news_and_weather/view/weather/forcast_weather_view.dart';
import 'package:news_and_weather/view/weather/today_weather_view.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(
    BuildContext context,
  ) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
              controller: tabController,
              labelColor: AppColors.primaryColor,
              indicatorColor: AppColors.primaryColor,
              tabs: [
                Tab(
                  text: "Current Weather",
                  icon: Icon(
                    Icons.timelapse,
                    color: Colors.indigo.shade500,
                  ),
                ),
                Tab(
                    text: "For cast",
                    icon: Icon(
                      Icons.calendar_month,
                      color: Colors.indigo.shade500,
                    )),
              ]),
          Expanded(
            child: TabBarView(controller: tabController, children: const [
              WeatherView(),
              ForecastWeatherView(),
            ]),
          ),
        ],
      ),
    );
  }
}
