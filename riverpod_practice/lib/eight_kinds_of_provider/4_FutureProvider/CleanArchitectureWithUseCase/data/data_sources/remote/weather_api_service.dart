// Data Layer — Remote API Service (Abstract)
// Defines the raw HTTP surface. Returns raw JSON (Map / List).
// Knows nothing about entities or models — parsing is the repository's job.
//
// The concrete implementation lives in weather_api_service_impl.dart.

abstract class WeatherApiService {
  // GET /v1/weather?city={city}
  //
  // Real-world implementation would look like:
  //   final res = await _dio.get('/weather', queryParameters: {'city': city});
  //   return res.data['data'] as Map<String, dynamic>;
  Future<Map<String, dynamic>> getWeather({required String city});
}
