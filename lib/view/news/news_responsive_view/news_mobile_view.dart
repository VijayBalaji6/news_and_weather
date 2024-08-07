import 'package:flutter/material.dart';
import 'package:news_and_weather/models/news_model.dart';
import 'package:news_and_weather/services/common_services.dart';

class NewsMobileView extends StatelessWidget {
  const NewsMobileView({
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
  }
}
