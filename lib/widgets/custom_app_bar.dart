import 'package:flutter/material.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/config/helpers.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.headerText,
    this.actionButton = const SizedBox(width: 0),
  });

  final String headerText;
  final Widget actionButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 55, 10, 10),
      decoration: const BoxDecoration(
        color: WeatherAppColor.cloudy,
        borderRadius: BorderRadius.zero,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const BackButton(
                color: WeatherAppColor.white,
              ),
              Text(
                headerText,
                style: Helpers.contentStyle(
                  22,
                  color: WeatherAppColor.white,
                ),
              )
            ],
          ),
          actionButton,
        ],
      ),
    );
  }
}
