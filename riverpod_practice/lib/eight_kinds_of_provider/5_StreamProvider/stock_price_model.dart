// A simple StockPrice class to simulate a realtime data stream

class StockPriceModel {
  final String symbol;
  final double price;
  final DateTime timestamp;

  StockPriceModel({
    required this.symbol,
    required this.price,
    required this.timestamp,
  });

  @override
  String toString() => '$symbol: \$$price';
}
