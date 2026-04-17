import 'dart:math';

import 'package:riverpod_practice/eight_kinds_of_provider/5_StreamProvider/stock_price_model.dart';

// A repository that simulates a realtime stock price stream

class StockRepository {
  // Returns a Stream that emits a new StockPrice every second
  Stream<StockPrice> watchStockPrice({required String symbol}) async* {
    final random = Random();
    double price = 150.0;

    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      // Simulate small price fluctuations
      price += (random.nextDouble() - 0.5) * 2;
      yield StockPrice(
        symbol: symbol,
        price: double.parse(price.toStringAsFixed(2)),
        timestamp: DateTime.now(),
      );
    }
  }
}
