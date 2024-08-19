import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_and_weather/models/news_model.dart';
import 'package:news_and_weather/provider/future_provider.dart';
import 'package:news_and_weather/responsive_layout/responsive_view.dart';
import 'package:news_and_weather/services/common_services.dart';
import 'package:news_and_weather/services/news_classification_services.dart';
import 'package:news_and_weather/view/news/news_responsive_view/news_mobile_view.dart';
import 'package:news_and_weather/view/news/news_responsive_view/news_tab_view.dart';

class NewsView extends ConsumerWidget {
  const NewsView({
    super.key,
  });

  final String placeHolderImage =
      "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<NewsModel> categoryNewsData =
        ref.watch(filteredNewsDataProvider);
    final weatherState = ref.watch(forecastDataProvider);
    return categoryNewsData.when(
      data: (NewsModel news) {
        if (news.articles != null && news.articles!.isNotEmpty) {
          final isTemHot = NewsClassificationService.determineTemperatureIsHot(
              weatherState.value!.list[0].main.temp);
          List<Articles> tempBasedNews =
              NewsClassificationService.sentimentAnalysis(
                  newsInput: news.articles, isOnlyHappyNews: isTemHot);
          return ListView.builder(
            shrinkWrap: true,
            itemCount: tempBasedNews.length,
            itemBuilder: (context, index) {
              final currentNews = tempBasedNews[index];
              return GestureDetector(
                onTap: () => CommonServices.openWebPage(
                    Uri.parse(currentNews.url ?? "")),
                child: ResponsiveView(
                    tab: NewsTabView(
                      currentNews: currentNews,
                    ),
                    mobile: NewsMobileView(
                      currentNews: currentNews,
                    )),
              );
            },
          );
        } else {
          return const Center(child: Text("No News for this climate"));
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
