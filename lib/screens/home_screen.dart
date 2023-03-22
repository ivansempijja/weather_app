import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/config/helpers.dart';
import 'package:weather_app/widgets/temp_row_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WeatherAppColor.sunny,
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: Helpers.displayHeight(context) * 0.5,
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
                  style: boldTextStyle(
                    size: 100,
                    color: WeatherAppColor.white,
                  ),
                ),
                const Text("Rainy"),
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
