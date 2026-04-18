import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/weather_model.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_repository.dart';

// Data Layer — Repository Implementation
// Concrete implementation of the domain's abstract repository.
// This is where the actual API calls, database queries, etc. happen.

// ─────────────────────────────────────────────────────────────────────────────
// REAL-WORLD API SAMPLE (for learning purposes)
//
// Imagine the backend exposes this endpoint:
//
//   GET https://api.weatherapp.com/v1/weather?city={city}
//
// ── REQUEST ──────────────────────────────────────────────────────────────────
//
//   GET /v1/weather?city=London HTTP/1.1
//   Host: api.weatherapp.com
//   Accept: application/json
//   Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
//
//   (as a curl command)
//   curl -X GET "https://api.weatherapp.com/v1/weather?city=London" \
//        -H "Accept: application/json" \
//        -H "Authorization: Bearer YOUR_TOKEN_HERE"
//
// ── SUCCESS RESPONSE (200 OK) ────────────────────────────────────────────────
//
//   HTTP/1.1 200 OK
//   Content-Type: application/json
//
//   {
//     "status": "ok",
//     "data": {
//       "city": "London",
//       "country": "GB",
//       "temperature": 22.5,
//       "feels_like": 21.8,
//       "humidity": 60,
//       "condition": "Sunny",
//       "wind_kph": 12.4,
//       "updated_at": "2026-04-18T14:30:00Z"
//     }
//   }
//
// ── ERROR RESPONSE (404 Not Found) ───────────────────────────────────────────
//
//   HTTP/1.1 404 Not Found
//   Content-Type: application/json
//
//   {
//     "status": "error",
//     "error": {
//       "code": "CITY_NOT_FOUND",
//       "message": "No weather data available for the given city."
//     }
//   }
//
// ── ERROR RESPONSE (401 Unauthorized) ────────────────────────────────────────
//
//   HTTP/1.1 401 Unauthorized
//   Content-Type: application/json
//
//   {
//     "status": "error",
//     "error": {
//       "code": "INVALID_TOKEN",
//       "message": "Access token is missing or invalid."
//     }
//   }
//
// ─────────────────────────────────────────────────────────────────────────────

class WeatherRepositoryImpl implements WeatherRepository {
  // In a real app you would inject an HTTP client here, e.g.:
  //   final Dio _dio;
  //   WeatherRepositoryImpl(this._dio);

  @override
  Future<WeatherEntity> getWeather({required String city}) async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 2));

    // ─── REAL IMPLEMENTATION (what this would look like with `dio` / `http`) ──
    //
    // final response = await _dio.get(
    //   'https://api.weatherapp.com/v1/weather',
    //   queryParameters: {'city': city},
    //   options: Options(
    //     headers: {
    //       'Accept': 'application/json',
    //       'Authorization': 'Bearer $token',
    //     },
    //   ),
    // );
    //
    // // Handle non-2xx responses
    // if (response.statusCode != 200) {
    //   final errorCode = response.data['error']?['code'] ?? 'UNKNOWN';
    //   final message   = response.data['error']?['message'] ?? 'Request failed';
    //   throw WeatherApiException(code: errorCode, message: message);
    // }
    //
    // // The real payload is nested under `data` — extract it before parsing
    // final Map<String, dynamic> payload = response.data['data'];
    // return WeatherModel.fromJson(payload);
    //
    // ─────────────────────────────────────────────────────────────────────────

    // FAKE IMPLEMENTATION (used here for demo purposes)
    // Mimics the shape the real API would return inside `data: {...}`.
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
}

// ─────────────────────────────────────────────────────────────────────────────
// EXAMPLE: POST / PUT request (for reference — not used in this demo)
//
// If the app needed to save a favorite city, the repository method would be:
//
//   Future<void> saveFavoriteCity(String city)
//
// ── REQUEST ──────────────────────────────────────────────────────────────────
//
//   POST /v1/favorites HTTP/1.1
//   Host: api.weatherapp.com
//   Content-Type: application/json
//   Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
//
//   {
//     "city": "London"
//   }
//
// ── RESPONSE (201 Created) ───────────────────────────────────────────────────
//
//   HTTP/1.1 201 Created
//   Content-Type: application/json
//
//   {
//     "status": "ok",
//     "data": {
//       "id": "fav_01HXYZ...",
//       "city": "London",
//       "created_at": "2026-04-18T14:35:00Z"
//     }
//   }
//
// The point: POST/PUT bodies are usually built from a Model's toJson().
// ─────────────────────────────────────────────────────────────────────────────
