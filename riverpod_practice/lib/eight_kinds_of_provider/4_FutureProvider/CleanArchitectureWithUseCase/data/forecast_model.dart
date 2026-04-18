import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/forecast_entity.dart';

// Data Layer — Forecast Model
//
// ── RAW JSON SAMPLE ──────────────────────────────────────────────────────────
//
//   {
//     "city": "London",
//     "days": [
//       {
//         "date": "2026-04-18",
//         "min_temp": 12.0,
//         "max_temp": 22.5,
//         "condition": "Sunny"
//       },
//       { "date": "2026-04-19", "min_temp": 13.2, "max_temp": 20.1, "condition": "Cloudy" },
//       ...
//     ]
//   }

class DailyForecastModel extends DailyForecastEntity {
  const DailyForecastModel({
    required super.date,
    required super.minTemp,
    required super.maxTemp,
    required super.condition,
  });

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) {
    return DailyForecastModel(
      date: DateTime.parse(json['date'] as String),
      minTemp: (json['min_temp'] as num).toDouble(),
      maxTemp: (json['max_temp'] as num).toDouble(),
      condition: json['condition'] as String,
    );
  }
}

class ForecastModel extends ForecastEntity {
  const ForecastModel({
    required super.city,
    required super.days,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final rawDays = json['days'] as List<dynamic>;
    return ForecastModel(
      city: json['city'] as String,
      days: rawDays
          .map((d) => DailyForecastModel.fromJson(d as Map<String, dynamic>))
          .toList(),
    );
  }
}
