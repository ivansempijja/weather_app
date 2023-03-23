import 'package:dio/dio.dart';
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

  fetchData(double latidute, double longitude) async {
    AppUnitsService appUnitsService = AppUnitsService();
    AppUnitsService appUnit = await appUnitsService.getAppUnits();

    final dio = Dio();
    try {
      Response response = await dio.get(
        API.currentWeatherUrl,
        queryParameters: {
          "lat": latidute,
          "lon": longitude,
          "appid": API.apiKey,
          "units": appUnit.unit
        },
      );
      return CurrentWeather.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response);
      return Future.error("error fetching weather data");
    }
  }
}
