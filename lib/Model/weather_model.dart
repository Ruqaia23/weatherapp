import 'dart:convert';

class WeatherData {
  final String name;
  final Temperature temperature;

  final int humidity;
  final Wind wind;
  final double maxTemperature;
  final double minTemperature;
  final int pressure;
  final int seaLevel;
  final List<WeatherInfo> weather;

  WeatherData({
    required this.name,
    required this.temperature,
    required this.humidity,
    required this.maxTemperature,
    required this.minTemperature,
    required this.pressure,
    required this.seaLevel,
    required this.weather,
    required this.wind,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      name: json['name'],
      temperature: Temperature.fromJson(json['main']),
      humidity: json['main']['humidity'],
      wind: Wind.fromJson(json['wind']),
      maxTemperature: (json['main']['temp_max'] - 300.05),
      minTemperature: (json['main']['temp_min'] - 297.56),
      pressure: json['main']['pressure'],
      seaLevel: json['main']['seaLevel'] ?? 0,
      weather: List<WeatherInfo>.from(
        json['weather'].map(
          (weather) => WeatherInfo.fromJson(weather),
        ),
      ),
    );
  }
}

class WeatherInfo {
  final String main;

  WeatherInfo({
    required this.main,
  });
  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      main: json['main'],
    );
  }
}

class Temperature {
  final double current;

  Temperature({required this.current});

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      current: (json['temp'] - 298.48),
    );
  }
}

class Wind {
  final double speed;

  Wind({required this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(speed: json['speed']);
  }
}
