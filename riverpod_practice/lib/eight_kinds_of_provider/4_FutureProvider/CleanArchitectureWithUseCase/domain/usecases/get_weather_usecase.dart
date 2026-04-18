import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/entities/weather_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/repositories/weather_repository.dart';

// Domain Layer — Use Case
// One action: fetch weather for a city (handles both the initial load and
// a user-initiated search). `call()` makes the class usable like a function.

class GetWeatherUseCase {
  final WeatherRepository _repository;

  GetWeatherUseCase(this._repository);

  Future<WeatherEntity> call({required String city}) {
    return _repository.getWeather(city: city);
  }
}
