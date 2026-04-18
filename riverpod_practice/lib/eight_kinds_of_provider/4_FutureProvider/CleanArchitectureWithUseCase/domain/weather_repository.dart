import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_entity.dart';

// Domain Layer — Repository Interface (Abstract)
// Defines WHAT the app can do, not HOW it does it.
// The data layer provides the concrete implementation.

abstract class WeatherRepository {
  Future<WeatherEntity> getWeather({required String city});
}
