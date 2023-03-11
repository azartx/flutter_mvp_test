import 'dart:convert';

import 'package:flutter_mvp_test/model/Response.dart';

import '../../model/ForecastResponse.dart';
import 'NetworkManager.dart';

class WeatherApi {

  static NetworkManager manager = NetworkManager("api.open-meteo.com");

  static Future<Response<ForecastResponse>> getForecast(String lat, String lon) async {
    final response = await manager.makeCall(
        "/v1/forecast",
        {'latitude':lat, 'longitude':lon, 'hourly': "temperature_2m", 'current_weather': "true"}
    );
    final responseBodyMap = json.decode(response.body) as Map<String, dynamic>;

    return Response(
        manager.isSuccess(response) ? ForecastResponse.createFromMap(responseBodyMap) : null,
      "",
      response.statusCode.toString()
    );
  }
}