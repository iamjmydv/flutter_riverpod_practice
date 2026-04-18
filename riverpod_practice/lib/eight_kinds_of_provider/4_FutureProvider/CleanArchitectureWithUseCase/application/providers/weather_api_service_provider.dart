import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/data_sources/remote/weather_api_service.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/data_sources/remote/weather_api_service_impl.dart';

// Application Layer — API Service Provider
// ONE LINE decides what the app runs on. Swap the return value for a fake
// in tests via ProviderContainer overrides.

final weatherApiServiceProvider = Provider<WeatherApiService>((ref) {
  return WeatherApiServiceImpl();
});
