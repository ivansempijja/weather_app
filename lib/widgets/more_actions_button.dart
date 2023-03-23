import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';

class MoreActionsButton extends StatelessWidget {
  const MoreActionsButton({
    super.key,
    required this.weatherColor,
  });

  final Color weatherColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 20,
      color: weatherColor,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 24,
              color: WeatherAppColor.white,
            ),
            title: Text(
              'Tap to view more Actions',
              style: primaryTextStyle(
                color: WeatherAppColor.white,
                size: 16,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_right_outlined,
              size: 24,
              color: WeatherAppColor.white,
            ),
          ),
        ],
      ),
    );
  }
}
