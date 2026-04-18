import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/entities/weather_entity.dart';

// Domain Layer — Repository contract. Defines WHAT, not HOW.

abstract class WeatherRepository {
  Future<WeatherEntity> getWeather({required String city});
}

// ─────────────────────────────────────────────────────────────
// REAL-WORLD API SAMPLE — Expanded repository contract
// ─────────────────────────────────────────────────────────────
// This contract is what the DOMAIN knows. Keep it expressed in
// entities, never in JSON. Expand as the product grows:
//
// abstract class WeatherRepository {
//   Future<WeatherEntity> getWeather({required String city});
//   Future<List<WeatherEntity>> getForecast({required String city, int days = 5});
//   Future<List<WeatherEntity>> getFavorites();
//   Future<void> addFavorite(String city);
//   Stream<WeatherEntity> watchCurrent({required String city}); // for live updates
// }
//
// Use cases (one action each) call into this — not the HTTP client.
// ─────────────────────────────────────────────────────────────

