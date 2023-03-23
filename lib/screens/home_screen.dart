import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/config/helpers.dart';
import 'package:weather_app/config/location_service.dart';
import 'package:weather_app/widgets/temp_row_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationService locationService = LocationService();
  void setUpview() async {
    Position currentLocation = await locationService.getLocation();
    double Longitude = currentLocation.longitude;
    double Latitude = currentLocation.latitude;
  }

  @override
  void initState() {
    setUpview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WeatherAppColor.sunny,
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: Helpers.displayHeight(context) * 0.45,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/forest_sunny.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "25${Helpers.degreeSymbol}",
                  style: primaryTextStyle(
                    size: 100,
                    color: WeatherAppColor.white,
                  ),
                ),
                Text(
                  "SUNNY",
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
            children: const <Widget>[
              TempRowText(temp: 19, text: "min"),
              TempRowText(temp: 19, text: "current"),
              TempRowText(temp: 19, text: "max"),
            ],
          ).paddingSymmetric(horizontal: 14),
          10.height,
        ],
      ),
    );
  }
}
