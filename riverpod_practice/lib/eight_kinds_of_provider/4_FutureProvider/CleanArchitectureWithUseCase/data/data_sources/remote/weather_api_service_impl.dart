import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/data_sources/remote/weather_api_service.dart';

// Data Layer — Implementation of WeatherApiService
// Returns raw JSON (Map). Nothing above the data layer knows or cares how
// the JSON was fetched — swap the body for a real HTTP call and everything
// else keeps working unchanged.

class WeatherApiServiceImpl implements WeatherApiService {
  // final Dio _dio;
  // WeatherApiServiceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> getWeather({required String city}) async {
    // Real-world implementation would look like:
    //   final res = await _dio.get('/weather', queryParameters: {'city': city});
    //   return res.data['data'] as Map<String, dynamic>;

    // Demo: fake JSON + delay so the UI's loading state is visible.
    await Future.delayed(const Duration(seconds: 1));
    return {
      'city': city,
      'temperature': 22.5,
      'condition': 'Sunny',
    };
  }
}
