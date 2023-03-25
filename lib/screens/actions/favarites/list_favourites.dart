import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/config/helpers.dart';
import 'package:weather_app/config/location_service.dart';
import 'package:weather_app/models/favourites.dart';
import 'package:weather_app/widgets/add_favourite_dialog.dart';
import 'package:weather_app/widgets/custom_app_bar.dart';

class ListFavourites extends StatefulWidget {
  const ListFavourites({super.key});

  @override
  State<ListFavourites> createState() => _ListFavouritesState();
}

class _ListFavouritesState extends State<ListFavourites> {
  late Position location;
  LocationService locationService = LocationService();

  void setLocation() async {
    Position loc = await locationService.getLocation();
    setState(() {
      location = loc;
    });
  }

  @override
  void initState() {
    setLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WeatherAppColor.white,
      body: Column(
        children: [
          CustomAppBar(
            headerText: "My Favorites",
            actionButton: GFButton(
              onPressed: () async {
                AddFavouriteDialog.showAlert(context, location);
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

              return Expanded(
                child: ListView.separated(
                  itemCount: box.values.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  itemBuilder: (context, index) {
                    Favourites? fav = box.getAt(index);
                    return Container(
                      margin: const EdgeInsets.all(8),
                      color: WeatherAppColor.white,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: WeatherAppColor.black,
                              ).paddingRight(5),
                              Text(
                                fav!.name!,
                                style: primaryTextStyle(
                                  color: WeatherAppColor.black,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Confirm",
                                          style: Helpers.contentStyle(18),
                                        ).paddingBottom(5),
                                        content: Text(
                                          "Are your sure you want to remove ${fav.name} from you favourites",
                                          style: Helpers.contentStyle(14),
                                        ),
                                        actions: [
                                          GFButton(
                                            onPressed: () {
                                              box.deleteAt(index);
                                              Navigator.of(context).pop();
                                            },
                                            text: "Yes",
                                            color: WeatherAppColor.cloudy,
                                            buttonBoxShadow: true,
                                          ),
                                          GFButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            text: "No",
                                            color: WeatherAppColor.bgGrey,
                                            buttonBoxShadow: true,
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              ),
                              const Icon(
                                Icons.remove_red_eye,
                                size: 20,
                                color: Colors.blue,
                              ).paddingLeft(20),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
