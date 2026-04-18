import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/data_sources/remote/weather_api_service.dart';

// Data Layer — Mock implementation of WeatherApiService
// Returns hardcoded JSON that matches the real API's response shape.
// `Future.delayed` simulates network latency so the UI's loading state is visible.
//
// Nothing above the data layer knows this is a mock — swap it for a real
// Dio-backed impl and the rest of the app keeps working unchanged.

class WeatherApiServiceMock implements WeatherApiService {
  @override
  Future<Map<String, dynamic>> getWeather({required String city}) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'city': city,
      'temperature': 22.5,
      'condition': 'Sunny',
    };
  }
}
