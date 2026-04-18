import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/entities/weather_entity.dart';

// Domain Layer — Repository Interface
// Defines WHAT the app can ask for, not HOW it's fetched.
// The data layer provides the implementation.

abstract class WeatherRepository {
  Future<WeatherEntity> getWeather({required String city});
}
