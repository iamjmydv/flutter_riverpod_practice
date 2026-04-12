import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/3_StateNotifierProvider/practice_StateNotifierProvider/p_counter_state_notifier_provider.dart';

class PStateNotifierProviderPage extends ConsumerWidget {
  const PStateNotifierProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pCounterProvider = ref.watch(testCounterNotifierProvider);
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () => ref.read(testCounterNotifierProvider.notifier).reset(),
        icon: Icon(
          Icons.restart_alt_sharp,
        ),
        style: IconButton.styleFrom(
          iconSize: 48.0,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pCounterProvider.toString(),
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(
              height: 48,
            ),
            Text(
              '** Practice StateNotifierProvider **',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => ref
                      .read(testCounterNotifierProvider.notifier)
                      .dicrement(),
                  child: Text('Minus -'),
                ),
                SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(testCounterNotifierProvider.notifier).add(),
                  child: Text('Add +'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
