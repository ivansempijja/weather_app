import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/config/helpers.dart';
import 'package:weather_app/config/location_service.dart';
import 'package:weather_app/models/favourites.dart';
import 'package:weather_app/screens/actions/favarites/list_map_view.dart';
import 'package:weather_app/widgets/add_favourite_dialog.dart';
import 'package:weather_app/widgets/custom_app_bar.dart';

class ListFavourites extends StatefulWidget {
  const ListFavourites({super.key});

  @override
  State<ListFavourites> createState() => _ListFavouritesState();
}

class _ListFavouritesState extends State<ListFavourites> {
  late Position location;
  bool isNotEmpty = false;
  LocationService locationService = LocationService();
  Box<Favourites> box = Hive.box<Favourites>("favourites");

  void setLocation() async {
    Position loc = await locationService.getLocation();
    setState(() {
      location = loc;
    });
  }

  @override
  void initState() {
    setLocation();
    isNotEmpty = box.isNotEmpty;
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
                AddFavouriteDialog.showAlert(
                  context,
                  location,
                  (bool onSave) {
                    setState(() {
                      isNotEmpty = onSave;
                    });
                  },
                );
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
            valueListenable: box.listenable(),
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
                                              Navigator.of(context).pop();
                                            },
                                            text: "No",
                                            color: WeatherAppColor.bgGrey,
                                            buttonBoxShadow: true,
                                          ),
                                          GFButton(
                                            onPressed: () {
                                              box.deleteAt(index);
                                              setState(() {
                                                isNotEmpty = box.isNotEmpty;
                                              });
                                              Navigator.of(context).pop(box);
                                            },
                                            text: "Yes",
                                            color: WeatherAppColor.cloudy,
                                            buttonBoxShadow: true,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: WeatherAppColor.cloudy,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Information",
                                          style: Helpers.contentStyle(18),
                                        ).paddingBottom(5),
                                        content: Text(
                                          "Location details using the places API have not yet been implemented.",
                                          style: Helpers.contentStyle(14),
                                        ),
                                        actions: [
                                          GFButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            text: "Dismiss",
                                            color: WeatherAppColor.bgGrey,
                                            buttonBoxShadow: true,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.remove_red_eye,
                                  size: 20,
                                  color: WeatherAppColor.black,
                                ),
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
      floatingActionButton: isNotEmpty
          ? FloatingActionButton.extended(
              icon: const Icon(
                Icons.map,
                color: WeatherAppColor.white,
              ),
              label: const Text("Map"),
              backgroundColor: WeatherAppColor.cloudy,
              onPressed: () {
                ListMapView(location: location).launch(context);
              },
            )
          : null,
    );
  }
}
