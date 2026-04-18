import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/entities/weather_entity.dart';

// Data Layer — Model
// Extends the domain entity and knows how to read/write JSON.
// This is the ONLY place JSON keys appear in the app.
//
// ── Sample JSON returned by the API ──
//   {
//     "city": "London",
//     "temperature": 22.5,
//     "condition": "Sunny"
//   }

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.city,
    required super.temperature,
    required super.condition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['city'] as String,
      // `as num` covers both int (22) and double (22.5)
      temperature: (json['temperature'] as num).toDouble(),
      condition: json['condition'] as String,
    );
  }
}
