import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/providers/future_providers.dart';

// Presentation Layer — Page
// Only depends on the application layer (providers). No direct imports from
// domain or data.

class FutureProviderPage extends ConsumerStatefulWidget {
  const FutureProviderPage({super.key});

  @override
  ConsumerState<FutureProviderPage> createState() => _FutureProviderPageState();
}

class _FutureProviderPageState extends ConsumerState<FutureProviderPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(cityQueryProvider));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search() {
    final query = _controller.text.trim();
    if (query.isEmpty) return;
    ref.read(cityQueryProvider.notifier).state = query;
  }

  @override
  Widget build(BuildContext context) {
    final weatherAsync = ref.watch(weatherFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(weatherFutureProvider),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      labelText: 'Search city',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _search(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
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
                        const Icon(Icons.wb_sunny,
                            size: 64, color: Colors.orange),
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
          ),
        ],
      ),
    );
  }
}
