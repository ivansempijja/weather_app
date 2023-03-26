import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/config/helpers.dart';
import 'package:weather_app/models/favourites.dart';

class AddFavouriteDialog {
  static void showAlert(
      BuildContext context, Position location, Function(bool) onSave) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();

    saveItem() {
      if (formKey.currentState!.validate()) {
        Box<Favourites> box = Hive.box<Favourites>("favourites");
        String name = nameController.text;
        box.add(Favourites(name: name, location: location));
        onSave(box.isNotEmpty);
        Navigator.of(context).pop();
      }
    }

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
                  Form(
                    key: formKey,
                    child: AppTextField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: "e.g Home"),
                      textFieldType: TextFieldType.NAME,
                      validator: Helpers.validateText,
                    ),
                  ),
                ],
              ).paddingSymmetric(vertical: 8),
            ),
            bottombar: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GFButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: "Cancel",
                  color: WeatherAppColor.bgGrey,
                  buttonBoxShadow: true,
                ),
                8.width,
                GFButton(
                  onPressed: () {
                    saveItem();
                  },
                  text: "Save",
                  color: WeatherAppColor.cloudy,
                  buttonBoxShadow: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
