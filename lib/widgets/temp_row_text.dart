import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/config/helpers.dart';

class TempRowText extends StatelessWidget {
  const TempRowText({super.key, required this.temp, required this.text});

  final int temp;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$temp${Helpers.degreeSymbol}",
          style: boldTextStyle(color: WeatherAppColor.white, size: 20),
        ),
        Text(
          text,
          style: primaryTextStyle(color: WeatherAppColor.white, size: 16),
        ),
      ],
    );
  }
}
