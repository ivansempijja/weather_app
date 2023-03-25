import 'package:charcode/html_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';

class Helpers {
  static Size displaySize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double displayHeight(BuildContext context) {
    return displaySize(context).height;
  }

  static String timeStampToday(int timestamp) {
    DateTime day = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('EEEE').format(day);
  }

  static TextStyle contentStyle(int size, {Color color = WeatherAppColor.black}) {
    return primaryTextStyle(
      decoration: TextDecoration.none,
      color: color,
      size: size,
    );
  }

  static String degreeSymbol = String.fromCharCode($deg);

  static Color setColor(String weather, String theme) {
    if (weather == "rainy") {
      return WeatherAppColor.rainy;
    }

    if (weather == "sunny") {
      if (theme == 'sea') {
        return WeatherAppColor.seaSunny;
      }

      return WeatherAppColor.sunny;
    }

    if (weather == "cloudy") {
      return WeatherAppColor.cloudy;
    }

    return WeatherAppColor.bgGrey;
  }

  static String setWeather(String weather) {
    if (weather == "Rain") {
      return "rainy";
    }

    if (weather == "Clear") {
      return "sunny";
    }

    if (weather == "Clouds") {
      return "cloudy";
    }

    return "Loading..";
  }

  static String setBackgroundImage(String weather, String theme) {
    return "assets/images/${theme}_$weather.png";
  }

  static String setweatherIcon(String weather) {
    String icon = "clear";
    if (weather == "Rain") {
      icon = "rain";
    }

    if (weather == "Clear") {
      icon = "clear";
    }

    if (weather == "Clouds") {
      icon = "partlysunny";
    }

    return "assets/icons/$icon@3x.png";
  }
}
