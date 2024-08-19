import 'package:news_and_weather/models/news_model.dart';
import 'package:sentiment_dart/sentiment_dart.dart';

class NewsClassificationService {
  static List<Articles> sentimentAnalysis(
      {List<Articles>? newsInput, required bool isOnlyHappyNews}) {
    if (newsInput == null) return [];

    List<Articles> filteredArticles = [];

    for (Articles article in newsInput) {
      final SentimentResult analysisResult =
          Sentiment.analysis(article.title ?? "");

      if (isOnlyHappyNews && analysisResult.score > 0.0) {
        filteredArticles.add(article);
      } else if (!isOnlyHappyNews && analysisResult.score <= 0.0) {
        filteredArticles.add(article);
      }
    }
    return filteredArticles;
    //{score: -2.0, comparative: -0.4, words: {all: [i, am, fear, of, tiger], good: {}, bad: {fear: -2}}}
  }

  static x(String inputData) {
    final SentimentResult analysisResult = Sentiment.analysis(inputData);
    analysisResult.score > 0.0;
  }

  static bool determineTemperatureIsHot(double? kelvin) {
    if (kelvin == null) {
      return false;
    }
    const double hotThreshold = 293.15; // 20°C in Kelvin
    return kelvin > hotThreshold;
  }
}
