import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp_test/presentation/screens/home/HomeScreenController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../../views/WeatherItemView.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final HomeScreenController _controller = HomeScreenController();

  String currentPlaceName = "Place: Loading";
  String currentTemperature = "Temperature: Loading";

  String maxTemperature = "Loading";
  String minTemperature = "Loading";

  @override
  void initState() {
    if (kIsWeb) {
      initWeb();
    } else {
      initForecast();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(DateFormat('yyyy-MM-dd HH:mm').format(
              DateTime.fromMillisecondsSinceEpoch(
                  DateTime.now().millisecondsSinceEpoch))),
        ),
        body: //SizedBox(
            // height: double.infinity,
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentPlaceName,
                style: Theme.of(context).textTheme.headlineMedium),
            Text(
              currentTemperature,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              "Min: $minTemperature, Max: $maxTemperature",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: _controller.currentForecastMap.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        children: _controller.currentForecast != null
                            ? mapToItemView(_controller.currentForecastMap)
                            : [],
                      ),
              ),
            )
          ],
          // )
        ));
  }

  List<WeatherItemView> mapToItemView(Map<String, String> itemsMap) {
    final List<WeatherItemView> list = [];

    _controller.currentForecastMap.forEach((key, value) {
      final time = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(key));
      list.add(WeatherItemView(time, value,
          () => {Fluttertoast.showToast(msg: "Temperature: $value")}));
    });
    return list;
  }

  void initWeb() async {
    await _controller.handlePermission();
    setState(() {});
    initForecast();
  }

  void initForecast() async {
    final forecast = await _controller.getForecast();

    setState(() {
      currentPlaceName = "Warsaw, Poland";

      currentTemperature =
          "${forecast.response!.currentWeather.temperature} °C";
      _controller.currentForecastMap = _controller.getForecastMap(
          forecast.response!.hourly.time,
          forecast.response!.hourly.temperature_2m);
      _controller.currentForecast = forecast.response;

      maxTemperature = _controller.currentForecast!.hourly.temperature_2m
          .reduce(max)
          .toString();
      minTemperature = _controller.currentForecast!.hourly.temperature_2m
          .reduce(min)
          .toString();
    });
  }
}
