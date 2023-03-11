class Hourly {
  final List<String> time;
  final List<double> temperature_2m;

  Hourly(this.time, this.temperature_2m);

  static Hourly createFromMap(Map<String, dynamic> params) {
    return Hourly((params["time"] as List<dynamic>).map((e) => e.toString()).toList(),
        (params["temperature_2m"] as List<dynamic>).map((e) => double.parse(e.toString())).toList());
  }
}