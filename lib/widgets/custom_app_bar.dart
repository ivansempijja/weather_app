import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.headerText,
  });

  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 55, 10, 10),
      decoration: const BoxDecoration(
        color: WeatherAppColor.cloudy,
        borderRadius: BorderRadius.zero,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const BackButton(
            color: WeatherAppColor.white,
          ),
          Text(
            headerText,
            style: primaryTextStyle(
              color: WeatherAppColor.white,
              size: 22,
            ),
          )
        ],
      ),
    );
  }
}