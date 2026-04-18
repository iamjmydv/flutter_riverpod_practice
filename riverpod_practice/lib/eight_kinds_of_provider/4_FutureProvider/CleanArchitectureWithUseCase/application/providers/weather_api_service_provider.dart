import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/data_sources/remote/weather_api_service.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/data_sources/remote/weather_api_service_impl.dart';

// Application Layer — API Service DI. Swap the impl to run against fakes.

final weatherApiServiceProvider = Provider<WeatherApiService>((ref) {
  return WeatherApiServiceImpl();
});

// ─────────────────────────────────────────────────────────────
// REAL-WORLD API SAMPLE — Wiring Dio + API key into the provider
// ─────────────────────────────────────────────────────────────
// A real API service needs an HTTP client and config (base URL,
// API key, timeouts, interceptors). Wire them with Providers:
//
// final dioProvider = Provider<Dio>((ref) {
//   final dio = Dio(BaseOptions(
//     baseUrl: 'https://api.openweathermap.org/data/2.5',
//     connectTimeout: const Duration(seconds: 10),
//     receiveTimeout: const Duration(seconds: 10),
//   ));
//   // Logging in debug only
//   dio.interceptors.add(LogInterceptor(responseBody: true));
//   return dio;
// });
//
// final apiKeyProvider = Provider<String>((ref) {
//   // Load from --dart-define or a config file — never hardcode.
//   return const String.fromEnvironment('OPENWEATHER_API_KEY');
// });
//
// final weatherApiServiceProvider = Provider<WeatherApiService>((ref) {
//   return WeatherApiServiceImpl(
//     ref.watch(dioProvider),
//     ref.watch(apiKeyProvider),
//   );
// });
// ─────────────────────────────────────────────────────────────

