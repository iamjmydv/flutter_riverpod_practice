import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/data_sources/remote/weather_api_service.dart';

// Data Layer — Fake implementation for the demo.
// Swap the body for a real HTTP call to go live.

class WeatherApiServiceImpl implements WeatherApiService {
  @override
  Future<Map<String, dynamic>> getWeather({required String city}) async {
    await Future.delayed(const Duration(seconds: 1));
    final normalized = city.trim();
    return {
      'city': normalized,
      'temperature': 15.0 + (normalized.hashCode % 20),
      'condition': _conditionFor(normalized),
    };
  }

  String _conditionFor(String city) {
    const conditions = ['Sunny', 'Cloudy', 'Rainy', 'Windy', 'Snowy'];
    return conditions[city.hashCode.abs() % conditions.length];
  }
}

// ─────────────────────────────────────────────────────────────
// REAL-WORLD API SAMPLE — OpenWeatherMap with Dio
// ─────────────────────────────────────────────────────────────
// Add to pubspec.yaml:  dio: ^5.4.0
//
// import 'package:dio/dio.dart';
//
// class WeatherApiServiceImpl implements WeatherApiService {
//   final Dio _dio;
//   final String _apiKey;
//
//   WeatherApiServiceImpl(this._dio, this._apiKey);
//
//   @override
//   Future<Map<String, dynamic>> getWeather({required String city}) async {
//     try {
//       final response = await _dio.get(
//         'https://api.openweathermap.org/data/2.5/weather',
//         queryParameters: {
//           'q': city,
//           'appid': _apiKey,
//           'units': 'metric',
//         },
//       );
//       return response.data as Map<String, dynamic>;
//     } on DioException catch (e) {
//       if (e.response?.statusCode == 404) {
//         throw Exception('City not found: $city');
//       }
//       throw Exception('Network error: ${e.message}');
//     }
//   }
// }
//
// Example JSON response from OpenWeatherMap:
// {
//   "name": "London",
//   "main": { "temp": 15.3, "humidity": 72 },
//   "weather": [ { "main": "Clouds", "description": "overcast clouds" } ]
// }
// ─────────────────────────────────────────────────────────────

