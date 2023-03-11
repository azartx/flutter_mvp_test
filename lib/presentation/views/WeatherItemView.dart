import 'package:flutter/material.dart';

class WeatherItemView extends StatelessWidget {
  const WeatherItemView(this._date, this._temperature, this.onClick, {super.key});

  final String _date;
  final String _temperature;
  final GestureTapCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: GestureDetector(
          onTap: onClick,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_date),
              const SizedBox(height: 8.0),
              Text("$_temperature °C")
            ],
          ),
        ));
  }
}
