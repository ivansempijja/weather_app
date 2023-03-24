import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/config/api.dart';
import 'package:weather_app/config/app_units_service.dart';

class CurrentWeather {
  final String? weather;
  final double? currentTemp;
  final double? minTemp;
  final double? maxTemp;

  CurrentWeather({
    this.weather,
    this.currentTemp,
    this.minTemp,
    this.maxTemp,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      weather: json["weather"][0]["main"],
      currentTemp: json["main"]["temp"],
      minTemp: json["main"]["temp_min"],
      maxTemp: json["main"]["temp_max"],
    );
  }

  fetchData(Position location) async {
    var response = await API.apiGetCall(API.currentWeatherUrl, location);
    if (response['error']) {
      return Future.error("error fetching weather data");
    }

    return CurrentWeather.fromJson(response['data']);
  }
}
