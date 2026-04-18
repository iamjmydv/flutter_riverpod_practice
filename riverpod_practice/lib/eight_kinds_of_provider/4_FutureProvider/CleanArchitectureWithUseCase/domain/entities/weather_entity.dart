// Domain Layer — Entity
// Pure Dart. No Flutter, no Riverpod, no packages.
// The core business object — what the rest of the app talks about.

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
