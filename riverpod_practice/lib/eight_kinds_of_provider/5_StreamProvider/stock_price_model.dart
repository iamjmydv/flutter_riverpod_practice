// A simple StockPrice class to simulate a realtime data stream

class StockPrice {
  final String symbol;
  final double price;
  final DateTime timestamp;

  StockPrice({
    required this.symbol,
    required this.price,
    required this.timestamp,
  });

  @override
  String toString() => '$symbol: \$$price';
}
