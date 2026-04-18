// Domain Layer — Pure Dart entity. No Flutter, Riverpod, or packages.

class WeatherEntity {
  final String city;
  final double temperature;
  final String condition;

  const WeatherEntity({
    required this.city,
    required this.temperature,
    required this.condition,
  });
}
