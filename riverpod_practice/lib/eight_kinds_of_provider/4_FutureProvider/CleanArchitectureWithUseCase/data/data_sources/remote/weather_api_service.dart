// Data Layer — Remote API Service (Abstract)
// Defines the raw HTTP surface. Returns raw JSON.

abstract class WeatherApiService {
  Future<Map<String, dynamic>> getWeather({required String city});
}
