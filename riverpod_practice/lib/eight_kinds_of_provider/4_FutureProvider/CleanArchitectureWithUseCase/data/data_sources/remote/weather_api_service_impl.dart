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
