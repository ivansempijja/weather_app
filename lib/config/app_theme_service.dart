
import 'package:nb_utils/nb_utils.dart';

class AppThemeService {
  final String? theme;

  AppThemeService({this.theme});

  factory AppThemeService.fromString(String theme) {
    return AppThemeService(theme: theme);
  }

  getAppTheme() async {
    final prefs = await SharedPreferences.getInstance();
    var appTheme = prefs.getString("appTheme");
    if (appTheme != null) {
      return AppThemeService.fromString(appTheme);
    }

    String defaultTheme = "forest";
    return setAppTheme(defaultTheme);
  }

  setAppTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("appTheme", theme);
    return AppThemeService.fromString(theme);
  }
}
