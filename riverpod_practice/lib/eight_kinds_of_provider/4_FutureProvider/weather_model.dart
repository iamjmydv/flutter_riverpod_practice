// A simple Weather class to simulate an API response

class Weather {
  final String city;
  final double temperature;
  final String condition;

  Weather({
    required this.city,
    required this.temperature,
    required this.condition,
  });

  @override
  String toString() => '$city: $temperature°C, $condition';
}
