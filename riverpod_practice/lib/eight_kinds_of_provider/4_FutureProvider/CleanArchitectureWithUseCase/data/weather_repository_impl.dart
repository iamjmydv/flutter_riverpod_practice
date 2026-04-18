import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/city_model.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/favorite_city_model.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/forecast_model.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/weather_model.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/city_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/favorite_city_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/forecast_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_repository.dart';

// ═════════════════════════════════════════════════════════════════════════════
// Data Layer — Repository Implementation
//
// Concrete implementation of the domain's abstract repository.
// This is the ONLY file in the app that talks to the network.
//
// In a real app, inject an HTTP client (dio, http, chopper, etc.):
//
//   class WeatherRepositoryImpl implements WeatherRepository {
//     final Dio _dio;
//     WeatherRepositoryImpl(this._dio);
//   }
//
// For this demo we use fake in-memory data and simulated delays so the
// whole app runs without a real backend. Every method below includes the
// real HTTP request/response shape as commented reference.
//
// Base URL used in the samples:   https://api.weatherapp.com/v1
// Auth scheme:                    Bearer token in `Authorization` header
// ═════════════════════════════════════════════════════════════════════════════

class WeatherRepositoryImpl implements WeatherRepository {
  // ── In-memory mock store for favorites (simulates a remote DB) ─────────────
  final List<Map<String, dynamic>> _favoritesStore = [
    {
      'id': 'fav_01HXYZ123ABC',
      'city': 'London',
      'created_at': '2026-04-10T10:00:00Z',
    },
    {
      'id': 'fav_02HXYZ456DEF',
      'city': 'Paris',
      'created_at': '2026-04-12T14:30:00Z',
    },
  ];

  int _nextFavoriteId = 3;

  // ═══════════════════════════════════════════════════════════════════════════
  //  GET /v1/weather?city={city}
  //
  //  ── REQUEST ──
  //    GET /v1/weather?city=London HTTP/1.1
  //    Host: api.weatherapp.com
  //    Accept: application/json
  //    Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
  //
  //  ── RESPONSE 200 OK ──
  //    {
  //      "status": "ok",
  //      "data": {
  //        "city": "London",
  //        "country": "GB",
  //        "temperature": 22.5,
  //        "feels_like": 21.8,
  //        "humidity": 60,
  //        "condition": "Sunny",
  //        "wind_kph": 12.4,
  //        "updated_at": "2026-04-18T14:30:00Z"
  //      }
  //    }
  //
  //  ── RESPONSE 404 NOT FOUND ──
  //    {
  //      "status": "error",
  //      "error": { "code": "CITY_NOT_FOUND", "message": "No weather data." }
  //    }
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Future<WeatherEntity> getWeather({required String city}) async {
    await Future.delayed(const Duration(seconds: 1));

    // Real code would be:
    //   final res = await _dio.get('/weather', queryParameters: {'city': city});
    //   return WeatherModel.fromJson(res.data['data']);

    final fakeJson = {
      'city': city,
      'country': 'GB',
      'temperature': 22.5,
      'feels_like': 21.8,
      'humidity': 60,
      'condition': 'Sunny',
      'wind_kph': 12.4,
      'updated_at': '2026-04-18T14:30:00Z',
    };
    return WeatherModel.fromJson(fakeJson);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  GET /v1/forecast?city={city}&days={days}
  //
  //  ── REQUEST ──
  //    GET /v1/forecast?city=London&days=3 HTTP/1.1
  //    Host: api.weatherapp.com
  //    Authorization: Bearer ...
  //
  //  ── RESPONSE 200 OK ──
  //    {
  //      "status": "ok",
  //      "data": {
  //        "city": "London",
  //        "days": [
  //          { "date": "2026-04-18", "min_temp": 12.0, "max_temp": 22.5, "condition": "Sunny" },
  //          { "date": "2026-04-19", "min_temp": 13.2, "max_temp": 20.1, "condition": "Cloudy" },
  //          { "date": "2026-04-20", "min_temp": 10.8, "max_temp": 18.4, "condition": "Rainy" }
  //        ]
  //      }
  //    }
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Future<ForecastEntity> getForecast({
    required String city,
    int days = 7,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    // Real code:
    //   final res = await _dio.get(
    //     '/forecast',
    //     queryParameters: {'city': city, 'days': days},
    //   );
    //   return ForecastModel.fromJson(res.data['data']);

    final now = DateTime.now();
    final fakeJson = {
      'city': city,
      'days': List.generate(days, (i) {
        final date = now.add(Duration(days: i));
        final conditions = ['Sunny', 'Cloudy', 'Rainy', 'Partly Cloudy'];
        return {
          'date': date.toIso8601String().split('T').first,
          'min_temp': 10.0 + (i % 5),
          'max_temp': 18.0 + (i % 7),
          'condition': conditions[i % conditions.length],
        };
      }),
    };
    return ForecastModel.fromJson(fakeJson);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  GET /v1/cities/search?q={query}
  //
  //  ── REQUEST ──
  //    GET /v1/cities/search?q=lon HTTP/1.1
  //    Host: api.weatherapp.com
  //    Authorization: Bearer ...
  //
  //  ── RESPONSE 200 OK ──
  //    {
  //      "status": "ok",
  //      "data": [
  //        { "name": "London",  "country": "GB", "latitude": 51.5073, "longitude": -0.1276 },
  //        { "name": "Long Beach", "country": "US", "latitude": 33.7701, "longitude": -118.1937 }
  //      ]
  //    }
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Future<List<CityEntity>> searchCities({required String query}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Real code:
    //   final res = await _dio.get('/cities/search', queryParameters: {'q': query});
    //   final list = res.data['data'] as List;
    //   return list.map((j) => CityModel.fromJson(j)).toList();

    const allCities = [
      {'name': 'London', 'country': 'GB', 'latitude': 51.5073, 'longitude': -0.1276},
      {'name': 'Long Beach', 'country': 'US', 'latitude': 33.7701, 'longitude': -118.1937},
      {'name': 'Paris', 'country': 'FR', 'latitude': 48.8566, 'longitude': 2.3522},
      {'name': 'Tokyo', 'country': 'JP', 'latitude': 35.6762, 'longitude': 139.6503},
      {'name': 'New York', 'country': 'US', 'latitude': 40.7128, 'longitude': -74.0060},
    ];

    final q = query.toLowerCase();
    final matches = allCities
        .where((c) => (c['name'] as String).toLowerCase().contains(q))
        .map((c) => CityModel.fromJson(c))
        .toList();

    return matches;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  GET /v1/favorites
  //
  //  ── REQUEST ──
  //    GET /v1/favorites HTTP/1.1
  //    Host: api.weatherapp.com
  //    Authorization: Bearer ...
  //
  //  ── RESPONSE 200 OK ──
  //    {
  //      "status": "ok",
  //      "data": [
  //        { "id": "fav_01...", "city": "London", "created_at": "2026-04-10T10:00:00Z" },
  //        { "id": "fav_02...", "city": "Paris",  "created_at": "2026-04-12T14:30:00Z" }
  //      ]
  //    }
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Future<List<FavoriteCityEntity>> getFavoriteCities() async {
    await Future.delayed(const Duration(milliseconds: 700));

    // Real code:
    //   final res = await _dio.get('/favorites');
    //   final list = res.data['data'] as List;
    //   return list.map((j) => FavoriteCityModel.fromJson(j)).toList();

    return _favoritesStore
        .map((j) => FavoriteCityModel.fromJson(j))
        .toList();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  POST /v1/favorites
  //
  //  ── REQUEST ──
  //    POST /v1/favorites HTTP/1.1
  //    Host: api.weatherapp.com
  //    Content-Type: application/json
  //    Authorization: Bearer ...
  //
  //    { "city": "Tokyo" }
  //
  //  ── RESPONSE 201 CREATED ──
  //    {
  //      "status": "ok",
  //      "data": {
  //        "id": "fav_03HXYZ789GHI",
  //        "city": "Tokyo",
  //        "created_at": "2026-04-18T15:00:00Z"
  //      }
  //    }
  //
  //  ── RESPONSE 409 CONFLICT ──
  //    {
  //      "status": "error",
  //      "error": { "code": "ALREADY_EXISTS", "message": "City is already a favorite." }
  //    }
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Future<FavoriteCityEntity> addFavoriteCity({required String city}) async {
    await Future.delayed(const Duration(milliseconds: 600));

    // Real code:
    //   final model = FavoriteCityModel(id: '', city: city, createdAt: DateTime.now());
    //   final res = await _dio.post('/favorites', data: model.toJson());
    //   return FavoriteCityModel.fromJson(res.data['data']);

    // Simulate 409 conflict
    final duplicate = _favoritesStore
        .any((f) => (f['city'] as String).toLowerCase() == city.toLowerCase());
    if (duplicate) {
      throw StateError('ALREADY_EXISTS: $city is already a favorite.');
    }

    final newRecord = {
      'id': 'fav_${_nextFavoriteId++}HXYZ${DateTime.now().millisecondsSinceEpoch}',
      'city': city,
      'created_at': DateTime.now().toUtc().toIso8601String(),
    };
    _favoritesStore.add(newRecord);
    return FavoriteCityModel.fromJson(newRecord);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  PUT /v1/favorites/{id}
  //
  //  ── REQUEST ──
  //    PUT /v1/favorites/fav_01HXYZ123ABC HTTP/1.1
  //    Host: api.weatherapp.com
  //    Content-Type: application/json
  //    Authorization: Bearer ...
  //
  //    { "city": "Manchester" }
  //
  //  ── RESPONSE 200 OK ──
  //    {
  //      "status": "ok",
  //      "data": {
  //        "id": "fav_01HXYZ123ABC",
  //        "city": "Manchester",
  //        "created_at": "2026-04-10T10:00:00Z"
  //      }
  //    }
  //
  //  ── RESPONSE 404 NOT FOUND ──
  //    {
  //      "status": "error",
  //      "error": { "code": "NOT_FOUND", "message": "Favorite does not exist." }
  //    }
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Future<FavoriteCityEntity> updateFavoriteCity({
    required String id,
    required String city,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    // Real code:
    //   final res = await _dio.put('/favorites/$id', data: {'city': city});
    //   return FavoriteCityModel.fromJson(res.data['data']);

    final index = _favoritesStore.indexWhere((f) => f['id'] == id);
    if (index == -1) {
      throw StateError('NOT_FOUND: Favorite $id does not exist.');
    }
    _favoritesStore[index] = {
      ..._favoritesStore[index],
      'city': city,
    };
    return FavoriteCityModel.fromJson(_favoritesStore[index]);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  DELETE /v1/favorites/{id}
  //
  //  ── REQUEST ──
  //    DELETE /v1/favorites/fav_01HXYZ123ABC HTTP/1.1
  //    Host: api.weatherapp.com
  //    Authorization: Bearer ...
  //
  //  ── RESPONSE 204 NO CONTENT ──
  //    (empty body)
  //
  //  ── RESPONSE 404 NOT FOUND ──
  //    {
  //      "status": "error",
  //      "error": { "code": "NOT_FOUND", "message": "Favorite does not exist." }
  //    }
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Future<void> removeFavoriteCity({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 400));

    // Real code:
    //   await _dio.delete('/favorites/$id');

    final removed = _favoritesStore.any((f) => f['id'] == id);
    if (!removed) {
      throw StateError('NOT_FOUND: Favorite $id does not exist.');
    }
    _favoritesStore.removeWhere((f) => f['id'] == id);
  }
}
