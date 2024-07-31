import 'package:flutter/material.dart';
import 'package:news_and_weather/constants/app_colors.dart';
import 'package:news_and_weather/view/news/filtered_news.dart';
import 'package:news_and_weather/view/news/news_view.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
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
                  text: "News",
                  icon: Icon(
                    Icons.timelapse,
                    color: Colors.indigo.shade500,
                  ),
                ),
                Tab(
                    text: "Filtered News",
                    icon: Icon(
                      Icons.calendar_month,
                      color: Colors.indigo.shade500,
                    )),
              ]),
          Expanded(
            child: TabBarView(controller: tabController, children: const [
              NewsView(),
              FilteredNews(),
            ]),
          ),
        ],
      ),
    );
  }
}
