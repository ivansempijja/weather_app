import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/config/helpers.dart';
import 'package:weather_app/config/location_service.dart';
import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/widgets/temp_row_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CurrentWeather currentWeather = CurrentWeather();
  LocationService locationService = LocationService();

  void setUpview() async {
    Position currentLocation = await locationService.getLocation();
    double lon = currentLocation.longitude;
    double lat = currentLocation.latitude;

    CurrentWeather weather = await currentWeather.fetchData(lat, lon);
    setState(() {
      minTemp = weather.minTemp!.round();
      maxTemp = weather.maxTemp!.round();
      currentTemp = weather.currentTemp!.round();
      String apiWeather = Helpers.setWeather(weather.weather!);
      weatherString = apiWeather.toUpperCase();
      weatherColor = Helpers.setColor(apiWeather);
      bgImage = Helpers.setBackgroundImage(apiWeather);
    });
  }

  int minTemp = 0;
  int maxTemp = 0;
  int currentTemp = 0;
  String weatherString = Helpers.setWeather("loading").toUpperCase();
  Color weatherColor = Helpers.setColor("loading");
  String bgImage = Helpers.setBackgroundImage("sunny");

  @override
  void initState() {
    setUpview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: weatherColor,
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: Helpers.displayHeight(context) * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bgImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "$currentTemp${Helpers.degreeSymbol}",
                  style: primaryTextStyle(
                    size: 100,
                    color: WeatherAppColor.white,
                  ),
                ),
                Text(
                  weatherString,
                  style: primaryTextStyle(
                    size: 50,
                    color: WeatherAppColor.white,
                  ),
                ),
              ],
            ),
          ),
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TempRowText(temp: minTemp, text: "min"),
              TempRowText(temp: currentTemp, text: "current"),
              TempRowText(temp: maxTemp, text: "max"),
            ],
          ).paddingSymmetric(horizontal: 14),
          10.height,
          const Divider(
            color: WeatherAppColor.white,
          ),
        ],
      ),
    );
  }
}
