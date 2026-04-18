import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_entity.dart';

// Data Layer — Model
// Extends or maps to the domain entity.
// In a real app, this handles JSON serialization/deserialization.

// ─────────────────────────────────────────────────────────────────────────────
// REAL-WORLD API SAMPLE (for learning purposes)
//
// The API returns many more fields than the app cares about.
// The Model decides which ones become part of the Entity.
//
// ── RAW JSON FROM THE API ────────────────────────────────────────────────────
//
//   {
//     "city": "London",
//     "country": "GB",                      ← ignored (not in entity)
//     "temperature": 22.5,
//     "feels_like": 21.8,                   ← ignored
//     "humidity": 60,                       ← ignored
//     "condition": "Sunny",
//     "wind_kph": 12.4,                     ← ignored
//     "updated_at": "2026-04-18T14:30:00Z"  ← ignored
//   }
//
// ── WHAT THE ENTITY KEEPS ────────────────────────────────────────────────────
//
//   WeatherEntity(
//     city: "London",
//     temperature: 22.5,
//     condition: "Sunny",
//   )
//
// The model is the filter between "everything the API sends" and
// "only what the app actually needs." Add a field to the entity when the
// UI / business logic needs it; leave it in JSON otherwise.
//
// ─────────────────────────────────────────────────────────────────────────────

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.city,
    required super.temperature,
    required super.condition,
  });

  // Factory to create from JSON.
  // Handles defensive parsing: int/double mix, missing fields, null values.
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['city'] as String,
      // `as num` covers both int (22) and double (22.5) from JSON
      temperature: (json['temperature'] as num).toDouble(),
      condition: json['condition'] as String,
    );
  }

  // Convert to JSON.
  // Used when the app needs to SEND data back to the server (POST/PUT).
  //
  // Example — saving a user's custom weather override:
  //
  //   POST /v1/weather/override
  //   Content-Type: application/json
  //
  //   {
  //     "city": "London",
  //     "temperature": 22.5,
  //     "condition": "Sunny"
  //   }
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'temperature': temperature,
      'condition': condition,
    };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ADVANCED: Handling a nested / envelope response
//
// Many APIs wrap the payload in an envelope like:
//
//   { "status": "ok", "data": { ... } }
//
// Option A — unwrap in the repository (recommended, keeps the model focused):
//
//   final payload = response.data['data'] as Map<String, dynamic>;
//   return WeatherModel.fromJson(payload);
//
// Option B — unwrap inside fromJson (model knows about the envelope):
//
//   factory WeatherModel.fromEnvelope(Map<String, dynamic> envelope) {
//     final data = envelope['data'] as Map<String, dynamic>;
//     return WeatherModel.fromJson(data);
//   }
//
// Prefer Option A — it keeps WeatherModel reusable even if the envelope
// shape changes.
// ─────────────────────────────────────────────────────────────────────────────
