import 'package:flutter_mvp_test/model/Hourly.dart';

import 'CurrentWeather.dart';
import 'HourlyUnits.dart';

class ForecastResponse {
  final double latitude;
  final double longitude;
  final double generationtime_ms;
  final double utc_offset_seconds;
  final String timezone;
  final String timezone_abbreviation;
  final double elevation;
  final HourlyUnits hourly_units;
  final Hourly hourly;
  final CurrentWeather currentWeather;

  ForecastResponse(
      this.latitude,
      this.longitude,
      this.generationtime_ms,
      this.utc_offset_seconds,
      this.timezone,
      this.timezone_abbreviation,
      this.elevation,
      this.hourly_units,
      this.hourly,
      this.currentWeather);

  static ForecastResponse createFromMap(Map<String, dynamic> params) {
    return ForecastResponse(
        double.parse(params["latitude"].toString()),
        double.parse(params["longitude"].toString()),
        double.parse(params["generationtime_ms"].toString()),
        double.parse(params["utc_offset_seconds"].toString()),
        params["timezone"],
        params["timezone_abbreviation"],
        double.parse(params["elevation"].toString()),
        HourlyUnits.createFromMap(params["hourly_units"]),
        Hourly.createFromMap(params["hourly"]),
        CurrentWeather.convertFromMap(params["current_weather"])
    );
  }
}
