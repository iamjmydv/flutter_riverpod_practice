import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/providers/weather_repository_provider.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/usecases/get_weather_usecase.dart';

// Application Layer — Use Case DI.

final getWeatherUseCaseProvider = Provider<GetWeatherUseCase>((ref) {
  return GetWeatherUseCase(ref.watch(weatherRepositoryProvider));
});
