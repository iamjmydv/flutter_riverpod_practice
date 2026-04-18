import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/entities/weather_entity.dart';

// Domain Layer — Repository contract. Defines WHAT, not HOW.

abstract class WeatherRepository {
  Future<WeatherEntity> getWeather({required String city});
}
