import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/data_sources/remote/weather_api_service.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/data_sources/remote/weather_api_service_impl.dart';

// Application Layer — API Service DI. Swap the impl to run against fakes.

final weatherApiServiceProvider = Provider<WeatherApiService>((ref) {
  return WeatherApiServiceImpl();
});
