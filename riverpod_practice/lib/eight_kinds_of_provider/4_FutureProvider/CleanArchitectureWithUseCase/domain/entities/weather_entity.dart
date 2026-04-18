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

// ─────────────────────────────────────────────────────────────
// REAL-WORLD API SAMPLE — Richer domain entity
// ─────────────────────────────────────────────────────────────
// Keep this file ZERO-dependency — no JSON, no Flutter, no packages.
// When the API returns more fields, enrich the entity as needed:
//
// class WeatherEntity {
//   final String city;
//   final double temperature;     // celsius
//   final double feelsLike;
//   final int humidity;           // percent
//   final double windSpeed;       // m/s
//   final String condition;       // "Clouds", "Rain", etc.
//   final String description;     // "overcast clouds"
//   final DateTime fetchedAt;
//
//   const WeatherEntity({
//     required this.city,
//     required this.temperature,
//     required this.feelsLike,
//     required this.humidity,
//     required this.windSpeed,
//     required this.condition,
//     required this.description,
//     required this.fetchedAt,
//   });
//
//   bool get isStale =>
//       DateTime.now().difference(fetchedAt) > const Duration(minutes: 10);
// }
// ─────────────────────────────────────────────────────────────

