import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/weather_provider.dart';

// Presentation Layer — Page (UI)
// Only knows about the application layer (providers).
// Has NO direct dependency on data, domain, or the use case class itself.
//
// The UI looks IDENTICAL to the no-use-case version — that's the point.
// Adding a use case doesn't change how the UI consumes the provider.

class FutureProviderPage extends ConsumerWidget {
  const FutureProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(weatherFutureProvider) returns AsyncValue<WeatherEntity>
    // Under the hood: Provider → UseCase → Repository → API
    final weatherAsync = ref.watch(weatherFutureProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Re-fetch by invalidating the FutureProvider
          ref.invalidate(weatherFutureProvider);
        },
        child: const Icon(Icons.refresh),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '* FutureProvider *',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Weather (Clean Architecture + UseCase)',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Use .when() to handle all three async states:
            //   loading → show a spinner
            //   error   → show the error message
            //   data    → show the actual weather data
            weatherAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (err, stack) => Text(
                'Error: $err',
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
              data: (weather) => Column(
                children: [
                  const Icon(Icons.wb_sunny, size: 64, color: Colors.orange),
                  const SizedBox(height: 16),
                  Text(
                    weather.city,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${weather.temperature}°C',
                    style: const TextStyle(fontSize: 48),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    weather.condition,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Text(
              'Tap refresh to re-fetch',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// CLEAN ARCHITECTURE WITH USE CASE SUMMARY:
//
// domain/
//   ├── weather_entity.dart         — core business object
//   ├── weather_repository.dart     — abstract interface (data contract)
//   └── usecases/
//       └── get_weather_usecase.dart — ONE specific action the app performs
//
// data/
//   ├── weather_model.dart            — JSON (de)serialization
//   └── weather_repository_impl.dart  — concrete API calls
//
// application/
//   ├── weather_repository_provider.dart   — DI for the repository
//   ├── get_weather_usecase_provider.dart  — DI for the use case
//   └── weather_provider.dart              — FutureProvider (calls the use case)
//
// presentation/
//   └── future_provider_page.dart   — UI only
//
// Call chain at runtime:
//   UI → weatherFutureProvider → GetWeatherUseCase → WeatherRepository → API
//
// To test: update main.dart to import this page as the home widget.
