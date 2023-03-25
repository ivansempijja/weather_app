import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/config/helpers.dart';
import 'package:weather_app/models/favourites.dart';
import 'package:weather_app/widgets/add_favourite_dialog.dart';
import 'package:weather_app/widgets/custom_app_bar.dart';

class ListFavourites extends StatefulWidget {
  const ListFavourites({super.key});

  @override
  State<ListFavourites> createState() => _ListFavouritesState();
}

class _ListFavouritesState extends State<ListFavourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WeatherAppColor.white,
      body: Column(
        children: [
          CustomAppBar(
            headerText: "My Favorites",
            actionButton: GFButton(
              onPressed: () {
                AddFavouriteDialog.showAlert(context);
              },
              text: "Add",
              icon: const Icon(
                Icons.add,
                color: WeatherAppColor.white,
              ),
              color: WeatherAppColor.cloudy,
              buttonBoxShadow: true,
            ),
          ),
          10.height,
          ValueListenableBuilder(
            valueListenable: Hive.box<Favourites>("favourites").listenable(),
            builder: (context, Box<Favourites> box, _) {
              if (box.values.isEmpty) {
                return Column(
                  children: [
                    Text(
                      "No favourites added",
                      style: Helpers.contentStyle(20),
                    ),
                  ],
                ).paddingTop(Helpers.displayHeight(context) * 0.3);
              }

              return const Text("Loading ..");
            },
          ),
        ],
      ),
    );
  }
}
