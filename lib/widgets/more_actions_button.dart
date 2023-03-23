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
      elevation: 15,
      color: weatherColor,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              print("ivan");
            },
            leading: const Icon(
              Icons.settings,
              size: 34,
              color: WeatherAppColor.white,
            ),
            title: Text(
              'More Actions',
              style: primaryTextStyle(
                color: WeatherAppColor.white,
                size: 14,
              ),
            ),
            subtitle: Text(
              'Manage theme, favorites, units and more',
              style: primaryTextStyle(
                color: WeatherAppColor.white,
                size: 12,
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
