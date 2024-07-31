import 'package:news_and_weather/models/weather/weather_model.dart';

class ForeCastModel {
  String cod;
  double message;
  int cnt;
  List<ListElement> list;
  City city;

  ForeCastModel({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory ForeCastModel.fromJson(Map<String, dynamic> json) {
    return ForeCastModel(
      cod: json['cod'],
      message: json['message'].toDouble(),
      cnt: json['cnt'],
      list: (json['list'] as List)
          .map((item) => ListElement.fromJson(item))
          .toList(),
      city: City.fromJson(json['city']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cod': cod,
      'message': message,
      'cnt': cnt,
      'list': list.map((item) => item.toJson()).toList(),
      'city': city.toJson(),
    };
  }
}

class City {
  int id;
  String name;
  Coord coord;
  String country;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      coord: Coord.fromJson(json['coord']),
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'coord': coord.toJson(),
      'country': country,
    };
  }
}

class Coord {
  double lat;
  double lon;

  Coord({
    required this.lat,
    required this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }
}

class ListElement {
  int dt;
  MainClass main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  Snow snow;
  Sys sys;
  DateTime dtTxt;

  ListElement({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.snow,
    required this.sys,
    required this.dtTxt,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) {
    return ListElement(
      dt: json['dt'],
      main: MainClass.fromJson(json['main']),
      weather: (json['weather'] as List)
          .map((item) => Weather.fromJson(item))
          .toList(),
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      snow: json['snow'] != null ? Snow.fromJson(json['snow']) : Snow(),
      sys: Sys.fromJson(json['sys']),
      dtTxt: DateTime.parse(json['dt_txt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'main': main.toJson(),
      'weather': weather.map((item) => item.toJson()).toList(),
      'clouds': clouds.toJson(),
      'wind': wind.toJson(),
      'snow': snow.toJson(),
      'sys': sys.toJson(),
      'dt_txt': dtTxt.toIso8601String(),
    };
  }
}

class Clouds {
  int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'all': all,
    };
  }
}

class MainClass {
  double temp;
  double tempMin;
  double tempMax;
  double pressure;
  double seaLevel;
  double grndLevel;
  int humidity;
  double tempKf;

  MainClass({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory MainClass.fromJson(Map<String, dynamic> json) {
    return MainClass(
      temp: json['temp'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'].toDouble(),
      seaLevel: json['sea_level'].toDouble(),
      grndLevel: json['grnd_level'].toDouble(),
      humidity: json['humidity'],
      tempKf: json['temp_kf'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'sea_level': seaLevel,
      'grnd_level': grndLevel,
      'humidity': humidity,
      'temp_kf': tempKf,
    };
  }
}

class Snow {
  double? the3H;

  Snow({
    this.the3H,
  });

  factory Snow.fromJson(Map<String, dynamic> json) {
    return Snow(
      the3H: json['3h']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '3h': the3H,
    };
  }
}

class Sys {
  Pod pod;

  Sys({
    required this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      pod: Pod.values.firstWhere((e) =>
          e.toString().toLowerCase() == 'Pod.${json['pod']}'.toLowerCase()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pod': pod.toString().split('.').last,
    };
  }
}

class Weather {
  int id;
  MainEnum? main;
  Description description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: MainEnum.values.isNotEmpty
          ? MainEnum.values.firstWhere(
              (e) =>
                  e.toString().toLowerCase() ==
                  'MainEnum.${json['main']}'.toLowerCase(),
              orElse: () => MainEnum.CLOUDS)
          : null,
      description: Description.values.firstWhere(
          (e) =>
              e.toString().toLowerCase() ==
              'Description.${json['description']}'.toLowerCase(),
          orElse: () => Description.BROKEN_CLOUDS),
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main.toString().split('.').last,
      'description': description.toString().split('.').last,
      'icon': icon,
    };
  }
}

enum Pod { D, N }

enum Description {
  BROKEN_CLOUDS,
  CLEAR_SKY,
  FEW_CLOUDS,
  LIGHT_SNOW,
  SCATTERED_CLOUDS,
}

enum MainEnum { CLEAR, CLOUDS, SNOW }
