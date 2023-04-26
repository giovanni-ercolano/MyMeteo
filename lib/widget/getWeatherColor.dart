import 'package:flutter/material.dart';

class WeatherColor extends StatelessWidget {
  final String description;

  const WeatherColor({Key? key, required this.description}) : super(key: key);

  Color getColorForWeather() {
    switch (description.toLowerCase()) {
      case 'heavy intensity rain':
        return Colors.deepPurple;
      case 'rain':
      case 'light rain':
        return Colors.blue;
      case 'snow':
        return Colors.lightBlueAccent;
      case 'clear sky':
        return Colors.yellow;
      case 'few clouds':
      case 'overcast clouds':
      case 'scattered clouds':
      case 'broken clouds':
        return Colors.grey;
      default:
        return Colors.white70;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getColorForWeather(),
      width: double.infinity,
      height: double.infinity,
    );
  }
}