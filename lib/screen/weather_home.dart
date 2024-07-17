import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
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
    weatherInfo = WeatherData(
      name: '',
      temperature: Temperature(current: 0.0),
      humidity: 0,
      maxTemperature: 0,
      minTemperature: 0,
      pressure: 0,
      seaLevel: 0,
      weather: [],
      wind: Wind(speed: 0.0),
    );
    myWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE D , MMMM yyyy').format(
      DateTime.now(),
    );
    String formattedTime = DateFormat('hh:mm a ').format(
      DateTime.now(),
    );
    return Scaffold(
      backgroundColor: Color(0xff676BD0),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: WeatherDetail(
                weather: weatherInfo,
                fromattedDate: formattedDate,
                fromattedTime: formattedTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  final WeatherData weather;
  final String fromattedDate;
  final String fromattedTime;

  const WeatherDetail({
    super.key,
    required this.weather,
    required this.fromattedDate,
    required this.fromattedTime,
  });

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
          '${weather.temperature.current.toStringAsFixed(2)}°C',
          style: const TextStyle(
              fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        if (weather.weather.isNotEmpty)
          Text(
            weather.weather[0].main,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        const SizedBox(height: 30),
        Text(
          fromattedDate,
          style: const TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          fromattedTime,
          style: const TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
