import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/entities/weather_entity.dart';

// Data Layer — Model
// The only place JSON keys appear in the app.

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.city,
    required super.temperature,
    required super.condition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['city'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      condition: json['condition'] as String,
    );
  }
}

// ─────────────────────────────────────────────────────────────
// REAL-WORLD API SAMPLE — Parsing OpenWeatherMap response
// ─────────────────────────────────────────────────────────────
// Real APIs rarely hand you flat keys. The Model is where you
// translate nested JSON into clean entity fields.
//
// factory WeatherModel.fromJson(Map<String, dynamic> json) {
//   final weatherList = json['weather'] as List<dynamic>;
//   final firstWeather = weatherList.first as Map<String, dynamic>;
//   final main = json['main'] as Map<String, dynamic>;
//
//   return WeatherModel(
//     city: json['name'] as String,
//     temperature: (main['temp'] as num).toDouble(),
//     condition: firstWeather['main'] as String,
//   );
// }
//
// For toJson() (e.g., caching to local storage):
//
// Map<String, dynamic> toJson() => {
//   'city': city,
//   'temperature': temperature,
//   'condition': condition,
// };
// ─────────────────────────────────────────────────────────────

