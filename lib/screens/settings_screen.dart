import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/screens/actions/select_theme.dart';
import 'package:weather_app/screens/actions/select_units.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/widgets/custom_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> actionsList = [
    'Refresh data',
    'Manage favourites',
    'Select app theme',
    'Select weather units',
  ];

  action(int tabIndex) async {
    if (tabIndex == 0) {
      const HomeScreen().launch(context, isNewTask: true);
    }

    if (tabIndex == 2) {
      const SelectTheme().launch(context);
    }

    if (tabIndex == 3) {
      const SelectUnits().launch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WeatherAppColor.white,
      body: Column(
        children: [
          const CustomAppBar(
            headerText: 'More App Actions',
          ),
          ListView.separated(
            itemCount: actionsList.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            padding: const EdgeInsets.only(left: 8, right: 8),
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.all(8),
                color: WeatherAppColor.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      actionsList[index],
                      style: primaryTextStyle(
                        color: WeatherAppColor.black,
                        size: 16,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      size: 20,
                      color: WeatherAppColor.black,
                    )
                  ],
                ),
              ).onTap(() {
                action(index);
              });
            },
          ).paddingOnly(left: 8, right: 8, top: 8),
        ],
      ),
    );
  }
}
