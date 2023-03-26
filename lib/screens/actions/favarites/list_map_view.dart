import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weather_app/config/color.dart';
import 'package:weather_app/models/favourites.dart';
import 'package:weather_app/widgets/custom_app_bar.dart';

class ListMapView extends StatefulWidget {
  const ListMapView({super.key, required this.location});

  final Position location;

  @override
  State<ListMapView> createState() => _ListMapViewState();
}

class _ListMapViewState extends State<ListMapView> {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  Box<Favourites> box = Hive.box<Favourites>("favourites");

  CameraPosition setIntialMarker() {
    return CameraPosition(
      target: LatLng(widget.location.latitude, widget.location.longitude),
      zoom: 14.4746,
    );
  }

  Marker makeMarker(int id, Position lac, String title) {
    return Marker(
      markerId: MarkerId('$id'),
      position: LatLng(lac.latitude, lac.longitude),
      infoWindow: InfoWindow(title: title),
    );
  }

  addMarkers() {
    markers.add(makeMarker(0, widget.location, "You"));
    for (int i = 0; i < box.length; i++) {
      Favourites? item = box.getAt(i);
      if (item != null) {
        markers.add(makeMarker(i + 1, item.location!, item.name!));
      }
    }
  }

  List<Marker> markers = <Marker>[];

  @override
  void initState() {
    addMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WeatherAppColor.white,
      body: Column(
        children: [
          const CustomAppBar(
            headerText: "Map view",
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: Set<Marker>.of(markers),
              initialCameraPosition: setIntialMarker(),
              onMapCreated: (GoogleMapController controller) {
                mapController.complete(controller);
              },
            ),
          )
        ],
      ),
    );
  }
}
