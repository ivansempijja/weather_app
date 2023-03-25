import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/config/helpers.dart';

class AddFavouriteDialog {
  static void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GFFloatingWidget(
          verticalPosition: Helpers.displayHeight(context) * 0.2,
          child: GFAlert(
            title: "Add to Favourites",
            titleTextStyle: Helpers.contentStyle(22),
            contentChild: Card(
              elevation: 0,
              child: Column(
                children: [
                  Text(
                    "Enter a name for the location and tap save to add it to your favourites",
                    style: Helpers.contentStyle(14),
                  ),
                  8.height,
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(hintText: "e.g Home"),
                  ),
                ],
              ).paddingSymmetric(vertical: 8),
            ),
            bottombar: Row(
              children: [
                GFButton(
                  onPressed: () {},
                  text: "Save",
                  color: WeatherAppColor.cloudy,
                  buttonBoxShadow: true,
                ),
                8.width,
                GFButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: "Cancel",
                  color: WeatherAppColor.bgGrey,
                  buttonBoxShadow: true,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
