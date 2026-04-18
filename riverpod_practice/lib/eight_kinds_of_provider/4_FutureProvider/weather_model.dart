// A simple Weather class to simulate an API response

class WeatherModel {
  final String city;
  final double temperature;
  final String condition;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.condition,
  });

  @override
  String toString() => '$city: $temperature°C, $condition';
}
