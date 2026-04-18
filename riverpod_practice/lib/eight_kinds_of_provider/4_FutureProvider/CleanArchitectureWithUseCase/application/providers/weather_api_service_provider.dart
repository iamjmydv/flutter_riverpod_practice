import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/data_sources/remote/weather_api_service.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/data_sources/remote/weather_api_service_mock.dart';

// Application Layer — API Service Provider
// ONE LINE decides whether the app runs on fake data or real HTTP.
//
//   Demo:        return WeatherApiServiceMock();
//   Production:  return WeatherApiServiceImpl(Dio(...));
//   Tests:       override this provider with a fake in a ProviderContainer.

final weatherApiServiceProvider = Provider<WeatherApiService>((ref) {
  return WeatherApiServiceMock();
});
