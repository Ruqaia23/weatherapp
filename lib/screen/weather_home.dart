import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weatherapp/Model/weather_model.dart';
import 'package:weatherapp/Services/services.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<WeatherHome> {
  late WeatherData weatherInfo;

  myWeather() {
    WeatherServices().fetchWeather().then((value) {
      setState(() {
        weatherInfo = value;
      });
    });
  }

  @override
  void initState() {
    myWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff676BD0),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Center(child: WeatherDetail(weather: weatherInfo))],
        ),
      ),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  final WeatherData weather;
  const WeatherDetail({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          weather.name,
          style: const TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          '${weather.temperature.current}',
          style: const TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
