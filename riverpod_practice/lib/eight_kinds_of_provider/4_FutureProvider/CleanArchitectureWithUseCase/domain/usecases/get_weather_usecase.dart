import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/entities/weather_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/repositories/weather_repository.dart';

// Domain Layer — Use Case
// One action: fetch weather for a city (handles both the initial load and
// a user-initiated search). `call()` makes the class usable like a function.

class GetWeatherUseCase {
  final WeatherRepository _repository;

  GetWeatherUseCase(this._repository);

  Future<WeatherEntity> call({required String city}) {
    return _repository.getWeather(city: city);
  }
}

// ─────────────────────────────────────────────────────────────
// REAL-WORLD API SAMPLE — Use Case with validation & business rules
// ─────────────────────────────────────────────────────────────
// Real use cases often hold business rules the UI shouldn't know:
// input validation, unit conversion, composing multiple repos, etc.
//
// class GetWeatherUseCase {
//   final WeatherRepository _repository;
//   final FavoritesRepository _favorites;
//
//   GetWeatherUseCase(this._repository, this._favorites);
//
//   Future<WeatherEntity> call({required String city}) async {
//     final normalized = city.trim();
//     if (normalized.isEmpty) {
//       throw const InvalidCityException('City cannot be empty');
//     }
//     if (normalized.length < 2) {
//       throw const InvalidCityException('City name too short');
//     }
//     final weather = await _repository.getWeather(city: normalized);
//     await _favorites.recordRecent(normalized); // side-effect
//     return weather;
//   }
// }
// ─────────────────────────────────────────────────────────────

