import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_repository.dart';

// Domain Layer — Use Case
// A Use Case represents ONE specific action the user can perform.
// Name it after the action: GetWeather, RefreshWeather, SearchCity, etc.
//
// Use cases sit BETWEEN the provider and the repository.
// They hold any business logic that doesn't belong in the UI or in the repository.
//
// Why not put this logic in the provider or the repository?
//   - Repository = pure data access (talk to API / DB)
//   - Use case   = business rules (validate, transform, combine sources)
//   - Provider   = Riverpod wiring + state management
//
// Keep each layer focused on one job.

class GetWeatherUseCase {
  final WeatherRepository _repository;

  GetWeatherUseCase(this._repository);

  // `call()` makes the class callable like a function:
  //   final getWeather = GetWeatherUseCase(repo);
  //   getWeather(city: 'London');   // same as getWeather.call(city: 'London')
  Future<WeatherEntity> call({required String city}) {
    // This example is simple (just delegates to the repository), but this
    // is the place where future business logic lives, e.g.:
    //   - validate the city name
    //   - convert °C ↔ °F based on user settings
    //   - log analytics events
    //   - combine weather + forecast from two repositories
    //   - cache / retry policy
    //
    // All of that stays out of the provider and out of the widget.
    return _repository.getWeather(city: city);
  }
}
