class HourlyUnits {
  final String time;
  final String temperature_2m;

  HourlyUnits(this.time, this.temperature_2m);

  static HourlyUnits createFromMap(Map<String, dynamic> params) {
    return HourlyUnits(params["time"], params["temperature_2m"]);
  }
}