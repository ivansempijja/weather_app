import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/config/api.dart';
import 'package:weather_app/config/helpers.dart';

class ForeCast {
  final String? day;
  final String? weather;
  final int? temp;
  final String? icon;
  final box = Hive.box('app_cache');

  ForeCast({this.day, this.weather, this.temp, this.icon});

  factory ForeCast.fromJson(Map<String, dynamic> json) {
    return ForeCast(
      day: Helpers.timeStampToday(
          json["dt"]), //get day of the week from timestamp
      weather: json["weather"][0]["main"],
      temp: (json["main"]["temp"]).round(), //roundoff API temp to int
      icon: Helpers.setweatherIcon(json["weather"][0]["main"]),
    );
  }

  factory ForeCast.fromPrams(int dt, String weather, double temp) {
    return ForeCast(
      day: Helpers.timeStampToday(dt), //get day of the week from timestamp
      weather: weather,
      temp: temp.round(), //roundoff API temp to int
      icon: Helpers.setweatherIcon(weather),
    );
  }

  // the five day forecast end point returns data intervals of 3 hours
  // so we need to manipulate our results to fetch one data point per day
  // to get more accurate daily data we need to use the daily forecast API
  // but it is a paid subscription :(
  // Solution: implement a loop that picks a single entry per day :)

  Future<List<ForeCast>> fetchData(Position location) async {
    var response = await API.apiGetCall(API.foreCastUrl, location);
    if (response['error']) {
      //on error try to retrive data from cache if empty return an exception
      if (box.containsKey('fore_cast')) {
        List<ForeCast> cacheJson = await getCache();
        return cacheJson;
      }

      return Future.error("Connection error");
    }

    List jsonResponse = [];
    for (int i = 1; i <= 5; i++) {
      int j = 8 * i;
      jsonResponse.add(response['data']['list'][j - 1]);
    }
    await box.put('fore_cast', jsonResponse);
    return jsonResponse.map((data) => ForeCast.fromJson(data)).toList();
  }

  Future getCache() async {
    List<dynamic> cacheJson = await box.get('fore_cast');
    return cacheJson
        .map(
          (e) => ForeCast.fromPrams(
            e["dt"],
            e["weather"][0]["main"],
            e["main"]["temp"],
          ),
        )
        .toList();
  }
}
