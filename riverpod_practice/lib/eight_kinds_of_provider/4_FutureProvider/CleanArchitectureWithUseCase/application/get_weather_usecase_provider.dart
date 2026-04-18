import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/weather_repository_provider.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/usecases/get_weather_usecase.dart';

// Application Layer — Use Case Provider
// Wires the use case to its dependency (the repository).
//
// The use case doesn't know about Riverpod — this provider is what
// injects the repository into it.

final getWeatherUseCaseProvider = Provider<GetWeatherUseCase>((ref) {
  final repository = ref.watch(weatherRepositoryProvider);
  return GetWeatherUseCase(repository);
});
