import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/5_StreamProvider/stock_price_model.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/5_StreamProvider/stock_repository.dart';

// StreamProvider is used for watching a Stream of results in realtime.
// Common use cases: Firebase auth state, realtime database, WebSockets, etc.

// Provider for the repository (plain Provider since it's a synchronous value)
final stockRepositoryProvider = Provider<StockRepository>((ref) {
  return StockRepository();
});

// StreamProvider — watches the repository and returns a Stream.
// autoDispose: automatically cancels the stream subscription when no longer listened to.
// The return type is automatically wrapped in AsyncValue<StockPrice>.
final stockPriceStreamProvider =
    StreamProvider.autoDispose<StockPrice>((ref) {
  final stockRepository = ref.watch(stockRepositoryProvider);
  return stockRepository.watchStockPrice(symbol: 'AAPL');
});


// StreamProvider overview:
//
// 1. Define a StreamProvider that returns a Stream<T>
// 2. When you ref.watch() it, the return type is AsyncValue<T>
//    (same as FutureProvider — loading, error, data)
// 3. Use .when() to map each state to a widget
//
// autoDispose modifier:
//   Cancels the stream subscription when no widget is listening.
//   Important for streams to avoid memory leaks.
//
// StreamProvider vs StreamBuilder:
//   - StreamProvider is declarative and integrates with other providers
//   - Automatically handles the stream lifecycle (subscribe/cancel)
//   - Can be combined with other providers using ref.watch()
//   - Supports .autoDispose to prevent memory leaks
