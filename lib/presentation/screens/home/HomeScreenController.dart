import 'package:flutter_mvp_test/data/network/WeatherApi.dart';

import '../../../model/ForecastResponse.dart';
import '../../../model/Response.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreenController {
  HomeScreenController();

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Position? currentPosition;
  ForecastResponse? currentForecast;
  Map<String, String> currentForecastMap = List.empty().asMap().cast<String, String>();

  Future<Response<ForecastResponse>> getForecast() async {
    final Position? position = await getCurrentPosition();
    if(position == null) { throw Exception("Not implemented yet."); }
    var forecast = await WeatherApi.getForecast(
        position.latitude.toString(),
        position.longitude.toString()
    );
    return forecast;
  }

  Future<Position?> getCurrentPosition() async {
    final hasPermission = await handlePermission();

    if (!hasPermission) {
      return null;
    }

    currentPosition = await _geolocatorPlatform.getCurrentPosition();
    return currentPosition!;
  }

  Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Map<String, String> getForecastMap(List<String> dates, List<double> temperatures) {
    return dates.asMap().map((key, value) =>
      MapEntry(value, temperatures[key].toString())
    );
  }
}
