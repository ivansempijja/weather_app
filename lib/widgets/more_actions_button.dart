import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/config/navigation_service.dart';
import 'package:weather_app/screens/settings_screen.dart';

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
              NavigationService().navigateToScreen(const SettingsScreen());
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
            ).paddingBottom(4),
            subtitle: Text(
              'Manage theme, favorites, units and more',
              style: primaryTextStyle(
                color: WeatherAppColor.white,
                size: 12,
              ),
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              size: 24,
              color: WeatherAppColor.white,
            ),
          ),
        ],
      ).paddingSymmetric(vertical: 10),
    );
  }
}
