// Data Layer — Remote API Service (Abstract)
// Defines the raw HTTP surface. Returns raw JSON.

abstract class WeatherApiService {
  Future<Map<String, dynamic>> getWeather({required String city});
}

// ─────────────────────────────────────────────────────────────
// REAL-WORLD API SAMPLE — OpenWeatherMap
// ─────────────────────────────────────────────────────────────
// Endpoint: https://api.openweathermap.org/data/2.5/weather?q={city}&appid={apiKey}&units=metric
//
// The contract above stays the same — only the impl changes.
// You could also expand the contract if you need more endpoints:
//
// abstract class WeatherApiService {
//   Future<Map<String, dynamic>> getWeather({required String city});
//   Future<Map<String, dynamic>> getForecast({required String city, int days = 5});
//   Future<List<Map<String, dynamic>>> searchCities({required String query});
// }
// ─────────────────────────────────────────────────────────────

