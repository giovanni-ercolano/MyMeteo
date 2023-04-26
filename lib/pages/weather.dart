import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widget/getWeatherColor.dart';
import '../widget/getWeatherIcon.dart';

class WeatherData {
  final String cityName;
  final num temperature;
  final String description;
  final List<WeatherForecastData> forecastData;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.forecastData,
  });

  factory WeatherData.fromJson(
      Map<String, dynamic> json, List<WeatherForecastData> forecastData) {
    final List<dynamic> weather = json['weather'];
    final Map<String, dynamic> weatherData = weather[0];
    final Map<String, dynamic> main = json['main'];
    final num temperature = main['temp'];
    final String description = weatherData['description'];

    return WeatherData(
      cityName: json['name'],
      temperature: temperature,
      description: description,
      forecastData: forecastData,
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>
    with AutomaticKeepAliveClientMixin<WeatherPage> {
  @override
  bool get wantKeepAlive => true;

  final _cityNameController = TextEditingController();
  WeatherData? _data;
  final List<String> _favoriteCities = [];

  Future<void> _fetchWeatherData() async {
    final cityName = _cityNameController.text;
    final data = await getWeatherData(cityName);
    setState(() {
      _data = data;
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: TextField(
                controller: _cityNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Inserisci il nome della città',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
              child: ElevatedButton(
                onPressed: _fetchWeatherData,
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Vedi Previsioni',
                  style:
                      TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),
                ),
              ),
            ),
            if (_data != null)
              FutureBuilder<WeatherData>(
                future: getWeatherData(_data!.cityName),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final weatherData = snapshot.data!;
                    return Column(
                      children: [
                        Stack(
                          children: [
                            // Icona del clima della città come sfondo del cerchio
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: WeatherColor(
                                        description: _data!.description)
                                    .getColorForWeather(),
                              ),
                              child: Center(
                                child: WeatherIcon(
                                  description: _data!.description,
                                ),
                              ),
                            ),
                            // Colonna con i dati del clima della città
                            Positioned.fill(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _data!.cityName,
                                    style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '${_data!.temperature.toStringAsFixed(1)} °C',
                                    style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    _data!.description,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        for (final forecast in _data!.forecastData)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ListTile(
                                leading: WeatherIcon(
                                  description: forecast.description,
                                  size: 38,
                                  color: WeatherColor(
                                          description: forecast.description)
                                      .getColorForWeather(),
                                ),
                                title: Text(forecast.date),
                                subtitle: Text(forecast.description),
                                trailing: Text(
                                  '${forecast.temperature.toStringAsFixed(1)} °C',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Failed to fetch weather data');
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                        strokeWidth: 4,
                      ),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}

class WeatherForecastData {
  final String date;
  final num temperature;
  final String description;

  WeatherForecastData({
    required this.date,
    required this.temperature,
    required this.description,
  });

  factory WeatherForecastData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> weather = json['weather'];
    final Map<String, dynamic> weatherData = weather[0];
    final Map<String, dynamic> main = json['main'];
    final num temperature = main['temp'];

    return WeatherForecastData(
      date: json['dt_txt'],
      temperature: temperature,
      description: weatherData['description'],
    );
  }
}

Future<WeatherData> getWeatherData(String cityName) async {
  const apiKey = 'db518e808bfe7200a4e13efd59891f54';
  final apiUrl =
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
  final forecastApiUrl =
      'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric&cnt=40';

  final weatherResponse = await http.get(Uri.parse(apiUrl));
  final forecastResponse = await http.get(Uri.parse(forecastApiUrl));

  if (weatherResponse.statusCode == 200 && forecastResponse.statusCode == 200) {
    final weatherJson = jsonDecode(weatherResponse.body);
    final forecastJson = jsonDecode(forecastResponse.body);
    final List<dynamic> forecastList = forecastJson['list'];
    final List<WeatherForecastData> forecastData = forecastList
        .map((forecast) => WeatherForecastData.fromJson(forecast))
        .toList();
    return WeatherData.fromJson(weatherJson, forecastData);
  } else {
    throw Exception('Failed to load weather data');
  }
}
