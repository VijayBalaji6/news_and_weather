import 'package:flutter/material.dart';
import 'package:news_and_weather/models/news_model.dart';
import 'package:news_and_weather/services/common_services.dart';

class NewsTabView extends StatelessWidget {
  const NewsTabView({
    super.key,
    required this.currentNews,
  });

  final Articles currentNews;
  final String placeHolderImage =
      "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CommonServices.openWebPage(Uri.parse(currentNews.url ?? "")),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: currentNews.urlToImage != null
            ? Image.network(
                currentNews.urlToImage!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            : Image.network(
                placeHolderImage,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
        title: Text(
          currentNews.title ?? "",
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          currentNews.description ?? "",
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.grey[700],
          ),
        ),
        isThreeLine: true,
        tileColor: Colors.white, // Optional: To give it a card-like appearance
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
