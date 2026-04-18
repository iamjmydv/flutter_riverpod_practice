import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitecture/domain/weather_entity.dart';

// Data Layer — Model
// Extends or maps to the domain entity.
// In a real app, this handles JSON serialization/deserialization.

class WeatherModel extends Weather {
  const WeatherModel({
    required super.city,
    required super.temperature,
    required super.condition,
  });

  // Factory to create from JSON (simulated)
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['city'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      condition: json['condition'] as String,
    );
  }

  // Convert to JSON (simulated)
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'temperature': temperature,
      'condition': condition,
    };
  }
}
