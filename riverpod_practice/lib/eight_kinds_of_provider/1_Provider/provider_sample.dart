import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerSample1 = Provider<String>((ref) {
  return 'This is \'Provider\' Sample 1';
});

final providerSample2 = Provider<String>(
  (ref) => 'This is \'Provider\' Sample 2',
);

final dateFormatterProvider = Provider<DateTime>(
  (ref) {
    return DateTime.now();
  },
);
