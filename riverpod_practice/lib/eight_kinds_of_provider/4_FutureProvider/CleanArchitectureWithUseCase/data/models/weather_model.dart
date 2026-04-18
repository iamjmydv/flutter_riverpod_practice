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
