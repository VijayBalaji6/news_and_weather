import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_and_weather/models/news_model.dart';
import 'package:news_and_weather/provider/future_provider.dart';
import 'package:news_and_weather/services/common_services.dart';

class NewsView extends ConsumerWidget {
  const NewsView({
    super.key,
  });

  final String placeHolderImage =
      "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(forecastDataProvider);

    final AsyncValue<NewsModel> categoryNewsData =
        ref.watch(filteredNewsDataProvider(weatherState.value != null
            ? weatherState.value!.list[0].main.temp > 255
                ? 'happiness'
                : 'none'
            : 'none'));

    return categoryNewsData.when(
      data: (NewsModel news) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: news.articles?.length ?? 0,
          itemBuilder: (context, index) {
            final currentNews = news.articles![index];
            return GestureDetector(
              onTap: () =>
                  CommonServices.openWebPage(Uri.parse(currentNews.url ?? "")),
              child: Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      currentNews.urlToImage ?? placeHolderImage,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentNews.title ?? "",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            currentNews.description ?? "",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
