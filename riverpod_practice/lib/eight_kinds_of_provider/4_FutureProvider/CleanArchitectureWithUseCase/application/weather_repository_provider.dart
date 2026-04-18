import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/weather_repository_impl.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_repository.dart';

// Application Layer — Repository Provider
// Typed as the ABSTRACT interface (WeatherRepository)
// but creates the CONCRETE implementation (WeatherRepositoryImpl).
// This is Dependency Inversion — swap implementations by changing one line.

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepositoryImpl();
});
