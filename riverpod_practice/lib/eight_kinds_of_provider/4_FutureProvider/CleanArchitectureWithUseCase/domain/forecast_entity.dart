// Domain Layer — Forecast Entity
// Pure Dart. Represents a multi-day forecast.

class DailyForecastEntity {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final String condition;

  const DailyForecastEntity({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.condition,
  });
}

class ForecastEntity {
  final String city;
  final List<DailyForecastEntity> days;

  const ForecastEntity({
    required this.city,
    required this.days,
  });
}
