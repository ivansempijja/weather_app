import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/config/api.dart';
import 'package:weather_app/config/app_units_service.dart';
import 'package:weather_app/config/helpers.dart';

class ForeCast {
  final String? day;
  final String? weather;
  final int? temp;
  final String? icon;

  ForeCast({this.day, this.weather, this.temp, this.icon});

  factory ForeCast.fromJson(Map<String, dynamic> json) {
    DateTime day = DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000);
    double currentTemp = json["main"]["temp"];
    String apiWeather = json["weather"][0]["main"];

    return ForeCast(
      day: DateFormat('EEEE').format(day), //get day of the week from timestamp
      weather: apiWeather,
      temp: currentTemp.round(), //roundoff API temp to int
      icon: Helpers.setweatherIcon(apiWeather),
    );
  }

  /**
   * the five day forecast end point returns data intervals of 3 hours
   * so we need to manipulate our results to fetch one data point per day
   * to get more accurate daily data we need to use the daily forecast API
   * but it is a paid subscription :(
   * 
   * Solution: for five days with 3 hour intervals, we get 40 data points
   * 8 day points for each day. So lets take the last data point for each day
   */

  ///fetch forecast data from open weather API
  Future<List<ForeCast>> fetchData(double latidute, double longitude) async {
    AppUnitsService appUnitsService = AppUnitsService();
    AppUnitsService appUnit = await appUnitsService.getAppUnits();

    final dio = Dio();
    try {
      Response response = await dio.get(
        API.foreCastUrl,
        queryParameters: {
          "lat": latidute,
          "lon": longitude,
          "appid": API.apiKey,
          "units": appUnit.unit
        },
      );

      List jsonResponse = [];
      for (int i = 1; i <= 5; i++) {
        //this loop adds one entry for each day to our forecast
        int j = 8 * i;
        jsonResponse.add(response.data["list"][j - 1]);
      }
      return jsonResponse.map((data) => ForeCast.fromJson(data)).toList();
    } on DioError catch (e) {
      print(e.response);
      return Future.error("error fetching weather data");
    }
  }
}
