import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/providers/usecase_providers.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/entities/weather_entity.dart';

// Application Layer — FutureProviders (what the UI watches)
//
// The UI watches `weatherFutureProvider`, which recomputes whenever the
// user changes `cityQueryProvider` via the search box.

final cityQueryProvider = StateProvider<String>((ref) => 'London');

final weatherFutureProvider =
    FutureProvider.autoDispose<WeatherEntity>((ref) {
  final getWeather = ref.watch(getWeatherUseCaseProvider);
  final city = ref.watch(cityQueryProvider);
  return getWeather(city: city);
});

// ─────────────────────────────────────────────────────────────
// REAL-WORLD API SAMPLE — Family + keepAlive + debounce
// ─────────────────────────────────────────────────────────────
// In production you'd usually:
//   • accept the city as a FAMILY argument instead of reading another provider
//   • keepAlive briefly so tab-switching doesn't re-fetch
//   • debounce rapid search input to avoid spamming the API
//
// final weatherFutureProvider = FutureProvider.autoDispose
//     .family<WeatherEntity, String>((ref, city) async {
//   // Cache the successful result for 30s even if no listeners.
//   final link = ref.keepAlive();
//   Timer? timer;
//   ref.onDispose(() => timer?.cancel());
//   ref.onCancel(() {
//     timer = Timer(const Duration(seconds: 30), link.close);
//   });
//   ref.onResume(() => timer?.cancel());
//
//   // Debounce: wait 300ms before firing the request.
//   await Future.delayed(const Duration(milliseconds: 300));
//   if (ref.mounted == false) throw Exception('cancelled');
//
//   return ref.watch(getWeatherUseCaseProvider)(city: city);
// });
//
// Usage in UI: ref.watch(weatherFutureProvider(city));
// ─────────────────────────────────────────────────────────────

