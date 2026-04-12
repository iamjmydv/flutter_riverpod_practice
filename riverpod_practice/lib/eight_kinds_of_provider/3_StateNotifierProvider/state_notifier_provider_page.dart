import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/3_StateNotifierProvider/state_notifier_provider_sample.dart';

class StateNotifierProviderPage extends ConsumerWidget {
  const StateNotifierProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(counterNotifierProvider) returns the STATE (int)
    final counter = ref.watch(counterNotifierProvider);
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () => ref.read(counterNotifierProvider.notifier).reset(),
        icon: Icon(Icons.refresh, color: Colors.white),
        style: IconButton.styleFrom(backgroundColor: Colors.blue),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '* StateNotifierProvider *',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Text(
              counter.toString(),
              style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ref.read(provider.notifier) gives access to the
                // StateNotifier object so we can call its methods
                ElevatedButton(
                  onPressed: () =>
                      ref.read(counterNotifierProvider.notifier).decrement(),
                  child: Text('- Subtract'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(counterNotifierProvider.notifier).increment(),
                  child: Text('+ Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// KEY DIFFERENCE: StateProvider vs StateNotifierProvider
//
// StateProvider:
//   ref.read(provider.notifier).state++     <-- directly mutate state
//
// StateNotifierProvider:
//   ref.read(provider.notifier).increment() <-- call named methods
//
// StateNotifierProvider is better when you have multiple ways to
// change the state (increment, decrement, reset) because the logic
// lives inside the StateNotifier class, not scattered across widgets.
//
// ref.watch(counterNotifierProvider)          -> returns the state (int)
// ref.read(counterNotifierProvider.notifier)  -> returns the CounterNotifier object
