import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/app_units_service.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/widgets/custom_app_bar.dart';

class SelectUnits extends StatefulWidget {
  const SelectUnits({super.key});

  @override
  State<SelectUnits> createState() => _SelectUnitsState();
}

class _SelectUnitsState extends State<SelectUnits> {
  AppUnitsService appUnitsService = AppUnitsService();
  void setUpview() async {
    AppUnitsService appUnit = await appUnitsService.getAppUnits();

    setState(() {
      if (appUnit.unit == "metric") {
        groupValue = 0;
      }

      if (appUnit.unit == "imperial") {
        groupValue = 1;
      }
    });
  }

  void setTheme(int value) async {
    if (value == 0) {
      appUnitsService.setUnits("metric");
    }

    if (value == 1) {
      appUnitsService.setUnits("imperial");
    }
    const HomeScreen().launch(context, isNewTask: true);
  }

  int groupValue = -1;

  @override
  void initState() {
    setUpview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WeatherAppColor.white,
      body: Column(
        children: [
          const CustomAppBar(
            headerText: 'Select App Units',
          ),
          GFRadioListTile(
            titleText: 'Metric',
            subTitleText: 'This is the way the universe should be.',
            avatar: const GFAvatar(
              backgroundColor: WeatherAppColor.white,
              backgroundImage: AssetImage("assets/images/metric.png"),
            ),
            size: 25,
            activeBorderColor: WeatherAppColor.cloudy,
            focusColor: WeatherAppColor.cloudy,
            type: GFRadioType.custom,
            value: 0,
            groupValue: groupValue,
            onChanged: (value) {
              setTheme(value);
              setState(() {
                groupValue = value;
              });
            },
            inactiveIcon: null,
          ),
          const Divider().paddingSymmetric(horizontal: 20),
          GFRadioListTile(
            titleText: 'Imperial',
            subTitleText: 'At your service my American friend',
            avatar: const GFAvatar(
              backgroundColor: WeatherAppColor.white,
              backgroundImage: AssetImage("assets/images/imperial.png"),
            ),
            size: 25,
            activeBorderColor: WeatherAppColor.cloudy,
            focusColor: WeatherAppColor.cloudy,
            type: GFRadioType.custom,
            value: 1,
            groupValue: groupValue,
            onChanged: (value) {
              setTheme(value);
              setState(() {
                groupValue = value;
              });
            },
            inactiveIcon: null,
          ),
        ],
      ),
    );
  }
}
