import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/forecast_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_repository.dart';

// Use Case — Get Forecast
// Fetch a multi-day forecast for a city.

class GetForecastUseCase {
  final WeatherRepository _repository;

  GetForecastUseCase(this._repository);

  Future<ForecastEntity> call({
    required String city,
    int days = 7,
  }) {
    // Business rule example: clamp `days` to a safe range.
    final clamped = days.clamp(1, 14);
    return _repository.getForecast(city: city, days: clamped);
  }
}
