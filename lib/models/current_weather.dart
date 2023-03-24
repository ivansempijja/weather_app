import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/config/api.dart';

class CurrentWeather {
  final String? weather;
  final double? currentTemp;
  final double? minTemp;
  final double? maxTemp;
  final box = Hive.box('app_cache');

  CurrentWeather({
    this.weather,
    this.currentTemp,
    this.minTemp,
    this.maxTemp,
  });

  factory CurrentWeather.fromList(list) {
    return CurrentWeather(
      weather: list[0],
      currentTemp: list[1],
      minTemp: list[2],
      maxTemp: list[3],
    );
  }

  fetchData(Position location) async {
    var response = await API.apiGetCall(API.currentWeatherUrl, location);
    if (response['error']) {
      if (box.containsKey('current_weather')) {
        List cacheResponse = await box.get("current_weather");
        return CurrentWeather.fromList(cacheResponse);
      }
      return Future.error("error fetching weather data");
    }

    List jsonResponse = [
      response['data']["weather"][0]["main"],
      response['data']["main"]["temp"],
      response['data']["main"]["temp_min"],
      response['data']["main"]["temp_max"],
    ];

    await box.put('current_weather', jsonResponse);
    return CurrentWeather.fromList(jsonResponse);
  }
}
