import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/5_StreamProvider/stream_provider_sample.dart';

class StreamProviderPage extends ConsumerWidget {
  const StreamProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(stockPriceStreamProvider) returns AsyncValue<StockPrice>
    // Each time the stream emits a new value, the widget rebuilds.
    final stockAsync = ref.watch(stockPriceStreamProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Invalidate to cancel the current stream and restart it
          ref.invalidate(stockPriceStreamProvider);
        },
        child: const Icon(Icons.refresh),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '* StreamProvider *',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Use .when() to handle all three async states
            // (same pattern as FutureProvider)
            stockAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (err, stack) => Text(
                'Error: $err',
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
              data: (stock) => Column(
                children: [
                  Icon(Icons.show_chart, size: 64, color: Colors.green),
                  const SizedBox(height: 16),
                  Text(
                    stock.symbol,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${stock.price}',
                    style: const TextStyle(fontSize: 48),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Updated: ${stock.timestamp.hour}:${stock.timestamp.minute.toString().padLeft(2, '0')}:${stock.timestamp.second.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Text(
              'Price updates every second',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// KEY CONCEPT: StreamProvider vs FutureProvider
//
// FutureProvider: resolves ONCE → great for one-shot API calls
// StreamProvider: emits MULTIPLE values over time → great for realtime data
//
// Both return AsyncValue<T> when watched, so the .when() pattern is identical.
//
// Real-world examples:
//   StreamProvider → Firebase authStateChanges(), Firestore snapshots(), WebSocket
//   FutureProvider → REST API call, reading a file, one-time database query
//
// To test: update main.dart to use StreamProviderPage as the home widget.
