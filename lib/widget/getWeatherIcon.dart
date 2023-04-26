import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String description;
  final double size;
  final Color color;

  const WeatherIcon({Key? key, required this.description,this.size = 120,
    this.color = Colors.white,}) : super(key: key);

  IconData getWeatherIcon() {
    switch (description) {
      case 'clear sky':
        return Icons.wb_sunny;
      case 'few clouds':
      case 'overcast clouds':
      case 'scattered clouds':
      case 'broken clouds':
        return Icons.cloud;
      case 'light rain':
        return Icons.grain;
      case 'snow':
        return Icons.ac_unit;
      case 'heavy intensity rain':
        return Icons.flash_on;
      default:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    IconData iconData = getWeatherIcon();
    return Icon(
      iconData,
      size: size,
      color: color,
    );
  }
}