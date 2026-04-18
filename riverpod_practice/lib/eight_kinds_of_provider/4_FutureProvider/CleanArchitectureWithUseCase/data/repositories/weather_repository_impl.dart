import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/data_sources/remote/weather_api_service.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/models/weather_model.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/entities/weather_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/repositories/weather_repository.dart';

// Data Layer — Takes JSON from the API service and returns a domain Entity.

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService _api;

  WeatherRepositoryImpl(this._api);

  @override
  Future<WeatherEntity> getWeather({required String city}) async {
    final json = await _api.getWeather(city: city);
    return WeatherModel.fromJson(json);
  }
}

// ─────────────────────────────────────────────────────────────
// REAL-WORLD API SAMPLE — Repository with caching & error mapping
// ─────────────────────────────────────────────────────────────
// In production, the Repository is where you combine data sources
// (remote + local cache) and translate raw errors into domain failures.
//
// class WeatherRepositoryImpl implements WeatherRepository {
//   final WeatherApiService _api;
//   final WeatherLocalDataSource _cache;
//
//   WeatherRepositoryImpl(this._api, this._cache);
//
//   @override
//   Future<WeatherEntity> getWeather({required String city}) async {
//     try {
//       final json = await _api.getWeather(city: city);
//       final model = WeatherModel.fromJson(json);
//       await _cache.save(city, model);        // cache on success
//       return model;
//     } on SocketException {
//       final cached = await _cache.get(city); // offline fallback
//       if (cached != null) return cached;
//       throw const NoInternetFailure();
//     } on FormatException {
//       throw const BadResponseFailure();
//     }
//   }
// }
// ─────────────────────────────────────────────────────────────

