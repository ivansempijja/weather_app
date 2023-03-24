import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/config/app_units_service.dart';

class API {
  static String apiKey = "57a8d86d429a9e31d765f321604d5713";

  static String currentWeatherUrl =
      "https://api.openweathermap.org/data/2.5/weather";

  static String foreCastUrl =
      "https://api.openweathermap.org/data/2.5/forecast";

  static Future apiGetCall(String url, Position currentLocation) async {
    AppUnitsService appUnitsService = AppUnitsService();
    AppUnitsService appUnit = await appUnitsService.getAppUnits();

    try {
      var dio = Dio();
      Response response = await dio.get(
        url,
        queryParameters: {
          "lat": currentLocation.latitude,
          "lon": currentLocation.longitude,
          "appid": API.apiKey,
          "units": appUnit.unit
        },
      );
      return {'error': false, 'data': response.data};
    } on DioError catch (e) {
      return {'error': true, 'data': e.response};
    }
  }
}
