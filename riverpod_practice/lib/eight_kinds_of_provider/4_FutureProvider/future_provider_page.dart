import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/future_provider_sample.dart';

class FutureProviderPage extends ConsumerWidget {
  const FutureProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(weatherFutureProvider) returns AsyncValue<Weather>
    // NOT Weather directly — because the Future may still be loading or may have failed.
    final weatherAsync = ref.watch(weatherFutureProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ref.invalidate re-triggers the FutureProvider (re-fetches data)
          // This is useful for pull-to-refresh style functionality.
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
                  Icon(Icons.wb_sunny, size: 64, color: Colors.orange),
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

// KEY CONCEPT: AsyncValue<T>
//
// When you watch a FutureProvider<T>, you get AsyncValue<T>, NOT T.
// AsyncValue wraps the three possible states of an async operation:
//
//   AsyncValue.loading()  → the Future is still running
//   AsyncValue.error()    → the Future threw an exception
//   AsyncValue.data()     → the Future completed with a value
//
// .when() is the recommended way to handle all three states.
//
// Refreshing data:
//   ref.invalidate(provider) → disposes & re-creates the provider
//   ref.refresh(provider)    → same, but also returns the new value
//
// To test: update main.dart to use FutureProviderPage as the home widget.
