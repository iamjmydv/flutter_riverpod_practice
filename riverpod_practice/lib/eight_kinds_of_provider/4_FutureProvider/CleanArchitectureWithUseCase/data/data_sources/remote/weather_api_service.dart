// Data Layer — Remote API Service (Abstract)
// Defines the raw HTTP surface. Returns raw JSON (Map / List).
// Knows nothing about entities or models — parsing is the repository's job.
//
// Two implementations exist:
//   - WeatherApiServiceMock  → fake JSON (used by the demo)
//   - WeatherApiServiceImpl  → real Dio/http version (not included — sketch below)
//
//       class WeatherApiServiceImpl implements WeatherApiService {
//         final Dio _dio;
//         WeatherApiServiceImpl(this._dio);
//
//         @override
//         Future<Map<String, dynamic>> getWeather({required String city}) async {
//           final res = await _dio.get('/weather', queryParameters: {'city': city});
//           return res.data['data'] as Map<String, dynamic>;
//         }
//       }
//
// Swap which one runs by editing ONE line in weather_api_service_provider.dart.

abstract class WeatherApiService {
  // GET /v1/weather?city={city}
  Future<Map<String, dynamic>> getWeather({required String city});
}
