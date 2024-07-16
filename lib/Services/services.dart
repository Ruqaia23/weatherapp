import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/Model/weather_model.dart';

class WeatherServices {
  fetchWeather() async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=24.7136&lon=46.6753&appid=2eded05b613bce9eddcb8c17a9270674'),
    );

    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return WeatherData.fromJson(json);
      } else {
        throw Exception('Failed to load Waither data');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
