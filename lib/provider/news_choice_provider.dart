import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<String> newsChoices = ['none', 'Happiness', 'Winning'];

class NewsChoiceNotifier extends StateNotifier<String> {
  NewsChoiceNotifier() : super(newsChoices[0]);

  void updateNewsChoice(String option) {
    state = option;
  }
}

final newsChoiceProvider =
    StateNotifierProvider<NewsChoiceNotifier, String>((ref) {
  return NewsChoiceNotifier();
});
