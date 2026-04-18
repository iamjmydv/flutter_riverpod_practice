// Domain Layer — Entity
// Pure Dart class with no dependencies on Flutter, Riverpod, or any package.
// Represents the core business object.

class WeatherEntity {
  final String city;
  final double temperature;
  final String condition;

  const WeatherEntity({
    required this.city,
    required this.temperature,
    required this.condition,
  });

  @override
  String toString() => '$city: $temperature°C, $condition';
}
