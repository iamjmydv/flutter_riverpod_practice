import 'dart:math';

import 'package:riverpod_practice/eight_kinds_of_provider/5_StreamProvider/stock_price_model.dart';

// A repository that simulates a realtime stock price stream

class StockRepository {
  // Returns a Stream that emits a new StockPrice every second
  Stream<StockPriceModel> watchStockPrice({required String symbol}) async* {
    final random = Random();
    double price = 150.0;

    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      // Simulate small price fluctuations
      price += (random.nextDouble() - 0.5) * 2;
      yield StockPriceModel(
        symbol: symbol,
        price: double.parse(price.toStringAsFixed(2)),
        timestamp: DateTime.now(),
      );
    }
  }
}

// ─────────────────────────────────────────────────────────────
// REAL-WORLD API SAMPLE — Finnhub WebSocket Stream
// ─────────────────────────────────────────────────────────────
// Add to pubspec.yaml:  web_socket_channel: ^2.4.0
//
// import 'dart:convert';
// import 'package:web_socket_channel/web_socket_channel.dart';
//
// class StockRepository {
//   final String _apiKey;
//
//   StockRepository(this._apiKey);
//
//   Stream<StockPrice> watchStockPrice({required String symbol}) async* {
//     final channel = WebSocketChannel.connect(
//       Uri.parse('wss://ws.finnhub.io?token=$_apiKey'),
//     );
//
//     // Subscribe to the symbol after the socket opens
//     channel.sink.add(jsonEncode({'type': 'subscribe', 'symbol': symbol}));
//
//     try {
//       await for (final message in channel.stream) {
//         final data = jsonDecode(message as String) as Map<String, dynamic>;
//         if (data['type'] != 'trade') continue;
//
//         final trades = data['data'] as List<dynamic>;
//         for (final trade in trades) {
//           final t = trade as Map<String, dynamic>;
//           yield StockPrice(
//             symbol: t['s'] as String,
//             price: (t['p'] as num).toDouble(),
//             timestamp: DateTime.fromMillisecondsSinceEpoch(t['t'] as int),
//           );
//         }
//       }
//     } finally {
//       channel.sink.add(jsonEncode({'type': 'unsubscribe', 'symbol': symbol}));
//       await channel.sink.close();
//     }
//   }
// }
//
// Example JSON message from Finnhub:
// {
//   "type": "trade",
//   "data": [
//     { "s": "AAPL", "p": 189.32, "t": 1713500000000, "v": 100 }
//   ]
// }
// ─────────────────────────────────────────────────────────────
