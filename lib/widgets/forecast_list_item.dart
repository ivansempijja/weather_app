import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/config/helpers.dart';

class ForeCastListItem extends StatelessWidget {
  const ForeCastListItem({
    super.key,
    required this.weatherIcon,
    required this.day,
    required this.temp,
  });

  final String weatherIcon;
  final String day;
  final int temp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            day,
            style: primaryTextStyle(
              color: WeatherAppColor.white,
              size: 18,
            ),
          ),
        ),
        Image(
          image: AssetImage(weatherIcon),
          height: 22,
        ).paddingRight(25),
        Text(
          "$temp${Helpers.degreeSymbol}",
          style: primaryTextStyle(
            color: WeatherAppColor.white,
            size: 18,
          ),
        ),
      ],
    ).paddingBottom(20);
  }
}
