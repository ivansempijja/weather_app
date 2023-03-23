import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/app_theme_service.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/widgets/custom_app_bar.dart';

class SelectTheme extends StatefulWidget {
  const SelectTheme({super.key});

  @override
  State<SelectTheme> createState() => _SelectThemeState();
}

class _SelectThemeState extends State<SelectTheme> {
  AppThemeService appThemeService = AppThemeService();

  void setUpview() async {
    AppThemeService appTheme = await appThemeService.getAppTheme();

    setState(() {
      if (appTheme.theme == "forest") {
        groupValue = 0;
      }

      if (appTheme.theme == "sea") {
        groupValue = 1;
      }
    });
  }

  void setTheme(int value) async {
    if (value == 0) {
      appThemeService.setAppTheme("forest");
    }

    if (value == 1) {
      appThemeService.setAppTheme("sea");
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
            headerText: 'Select App theme',
          ),
          GFRadioListTile(
            titleText: 'Forest',
            subTitleText: 'A forest is an area of land dominated by trees.',
            avatar: const GFAvatar(
              backgroundImage: AssetImage("assets/images/forest_sunny.png"),
            ),
            size: 25,
            activeBorderColor: Colors.green,
            focusColor: Colors.green,
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
            titleText: 'Sea',
            subTitleText: 'Sea refers to a large body of salty water.',
            avatar: const GFAvatar(
              backgroundImage: AssetImage("assets/images/sea_sunny.png"),
            ),
            size: 25,
            activeBorderColor: Colors.green,
            focusColor: Colors.green,
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
