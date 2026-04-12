import 'package:flutter_riverpod/legacy.dart';

class PCounterNotifierProvider extends StateNotifier<int> {
  PCounterNotifierProvider() : super(0);

  void add() {
    state++;
  }

  void dicrement() => state--;

  void reset() => state = 0;
}

final testCounterNotifierProvider =
    StateNotifierProvider<PCounterNotifierProvider, int>((ref) {
      return PCounterNotifierProvider();
    });
