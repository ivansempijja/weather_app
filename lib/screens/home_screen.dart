import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/config/helpers.dart';
import 'package:weather_app/config/location_service.dart';
import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/models/fore_cast.dart';
import 'package:weather_app/widgets/forecast_list_item.dart';
import 'package:weather_app/widgets/temp_row_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ForeCast foreCast = ForeCast();
  CurrentWeather currentWeather = CurrentWeather();
  LocationService locationService = LocationService();
  Future<List<ForeCast>>? foreCasts;

  void setUpview() async {
    Position currentLocation = await locationService.getLocation();
    double lon = currentLocation.longitude;
    double lat = currentLocation.latitude;

    foreCasts = foreCast.fetchData(lat, lon);
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
          FutureBuilder<List<ForeCast>>(
            future: foreCasts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ForeCast>? data = snapshot.data;
                if (data!.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Could not fetch forecast data",
                        style: primaryTextStyle(
                            color: WeatherAppColor.white, size: 18),
                      ).paddingTop(40),
                    ],
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 15),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ForeCastListItem(
                        day: data[index].day!,
                        weatherIcon: data[index].icon!,
                        temp: data[index].temp!,
                      );
                    },
                  ).paddingSymmetric(horizontal: 10),
                );
              }

              //show loader when fetching data
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 35,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: WeatherAppColor.white,
                    ),
                  ).paddingTop(40)
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
