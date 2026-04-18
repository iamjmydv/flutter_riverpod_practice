import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/entities/weather_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/repositories/weather_repository.dart';

// Domain Layer — Use Case
// ONE specific action the user can perform. Name it after the action.
//
// Use cases sit BETWEEN the provider and the repository:
//   - Repository = data access   (talk to API / DB)
//   - Use Case   = business rules (validate, transform, combine)
//   - Provider   = Riverpod wiring
//
// Today this one just delegates. That's fine — when rules get added
// later (e.g. °C↔°F conversion, caching, analytics), they live HERE
// and the provider stays a one-liner.

class GetWeatherUseCase {
  final WeatherRepository _repository;

  GetWeatherUseCase(this._repository);

  // `call()` lets you use the class like a function:
  //   final getWeather = ref.watch(getWeatherUseCaseProvider);
  //   getWeather(city: 'London');
  Future<WeatherEntity> call({required String city}) {
    return _repository.getWeather(city: city);
  }
}
