import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'favourites.g.dart';

@HiveType(typeId: 0)
class Favourites {
  @HiveField(0)
  final String? name;

  @HiveType(typeId: 1)
  final Position? location;

  Favourites({this.name, this.location});
}
