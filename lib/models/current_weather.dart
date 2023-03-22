class CurrentWeather {
  final String? weather;
  final double? currentTemp;
  final double? minTemp;
  final double? maxTemp;

  CurrentWeather({
    this.weather,
    this.currentTemp,
    this.minTemp,
    this.maxTemp,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      weather: "ivan",
      currentTemp: 0.0,
      minTemp: 0.0,
      maxTemp: 0.0,
    );
  }
}
