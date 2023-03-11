class CurrentWeather {
  final String time;
  final double temperature;
  final int weathercode;
  final double windspeed;
  final double winddirection;

  CurrentWeather(this.time,
      this.temperature,
      this.weathercode,
      this.windspeed,
      this.winddirection);

  static CurrentWeather convertFromMap(Map<String, dynamic> map) {
    return CurrentWeather(
        map["time"],
        double.parse(map["temperature"].toString()),
        map["weathercode"],
        double.parse(map["windspeed"].toString()),
        double.parse(map["winddirection"].toString())
    );
  }
}