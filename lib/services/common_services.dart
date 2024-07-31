import 'package:url_launcher/url_launcher.dart';

class CommonServices {
  static Future<void> openWebPage(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  static String convertKelvinToTemp(
      {required double kelvin, bool toCelsius = true}) {
    return toCelsius
        ? "${(kelvin - 273.15).toStringAsFixed(2)}°C"
        : "${((kelvin - 273.15) * 9 / 5 + 32).toStringAsFixed(2)}°F";
  }
}
