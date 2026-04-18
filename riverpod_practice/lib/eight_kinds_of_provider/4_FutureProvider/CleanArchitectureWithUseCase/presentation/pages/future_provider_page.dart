import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/providers/future_providers.dart';

// Presentation Layer — Page
// Only depends on the application layer (providers). No direct imports from
// domain or data. That's the whole point of clean architecture:
// the UI can't accidentally reach into the network or the repository.

class FutureProviderPage extends ConsumerWidget {
  const FutureProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Architecture Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(weatherFutureProvider),
          ),
        ],
      ),
      body: Center(
        child: weatherAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, _) => Text(
            'Error: $err',
            style: const TextStyle(color: Colors.red),
          ),
          data: (weather) => Card(
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.wb_sunny, size: 64, color: Colors.orange),
                  const SizedBox(height: 16),
                  Text(
                    weather.city,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${weather.temperature}°C — ${weather.condition}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
