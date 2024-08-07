import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_and_weather/models/news_model.dart';
import 'package:news_and_weather/provider/future_provider.dart';
import 'package:news_and_weather/provider/news_choice_provider.dart';
import 'package:news_and_weather/responsive_layout/responsive_view.dart';
import 'package:news_and_weather/view/news/news_responsive_view/news_mobile_view.dart';
import 'package:news_and_weather/view/news/news_responsive_view/news_tab_view.dart';

class FilteredNews extends ConsumerWidget {
  const FilteredNews({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String category = ref.watch(newsChoiceProvider);

    final AsyncValue<NewsModel> filteredNewsData =
        ref.watch(filteredNewsDataProvider(category));
    return filteredNewsData.when(
      data: (NewsModel news) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: news.articles?.length ?? 0,
          itemBuilder: (context, index) {
            final currentNews = news.articles![index];
            return ResponsiveView(
                tab: NewsTabView(
                  currentNews: currentNews,
                ),
                mobile: NewsMobileView(
                  currentNews: currentNews,
                ));
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
