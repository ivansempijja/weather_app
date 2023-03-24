import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:getwidget/getwidget.dart';
import 'package:weather_app/config/color.dart';
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
              onPressed: () {},
              text: "Add",
              icon: const Icon(
                Icons.add,
                color: WeatherAppColor.white,
              ),
              color: WeatherAppColor.cloudy,
              buttonBoxShadow: true,
            ),
          ),
        ],
      ),
    );
  }
}
