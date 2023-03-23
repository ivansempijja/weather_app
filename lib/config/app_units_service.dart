import 'package:nb_utils/nb_utils.dart';

class AppUnitsService {
  final String? unit;

  AppUnitsService({this.unit});

  factory AppUnitsService.fromString(String unit) {
    return AppUnitsService(unit: unit);
  }

  getAppUnits() async {
    final prefs = await SharedPreferences.getInstance();
    var appUnits = prefs.getString("appUits");
    if (appUnits != null) {
      return AppUnitsService.fromString(appUnits);
    }

    String units = "metric";
    return setUnits(units);
  }

  setUnits(String units) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("appUits", units);
    return AppUnitsService.fromString(units);
  }
}
