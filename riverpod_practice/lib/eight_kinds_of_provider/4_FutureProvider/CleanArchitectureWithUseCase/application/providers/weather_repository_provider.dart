import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/providers/weather_api_service_provider.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/repositories/weather_repository_impl.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/repositories/weather_repository.dart';

// Application Layer — Repository Provider
// Typed as the ABSTRACT interface, built with the CONCRETE impl,
// wired with whichever API service is registered above.

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepositoryImpl(ref.watch(weatherApiServiceProvider));
});
