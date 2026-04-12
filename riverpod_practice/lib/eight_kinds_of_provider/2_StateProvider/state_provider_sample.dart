import 'package:flutter_riverpod/legacy.dart';

final counterStateProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);
