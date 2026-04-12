import 'package:flutter_riverpod/legacy.dart';

// StateNotifier is a class that holds a single piece of state
// and exposes methods to modify it.
// Think of it as a "controller" for your state with named actions.

class CounterNotifier extends StateNotifier<int> {
  // Initialize the state with 0
  CounterNotifier() : super(0);

  // Named methods to modify the state
  void increment() => state++;

  void decrement() {
    if (state > 0) state--;
  }

  void reset() => state = 0;
}

// StateNotifierProvider has TWO type parameters:
// 1. The StateNotifier class (CounterNotifier)
// 2. The state type it holds (int)
final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>((
  ref,
) {
  return CounterNotifier();
});


// Both files are clean. Here's what was created:

// state_notifier_provider_sample.dart — The provider file:

// CounterNotifier extends StateNotifier<int> with three named methods: increment(), decrement(), and reset()
// counterNotifierProvider is defined with two type parameters: <CounterNotifier, int>
// state_notifier_provider_page.dart — The widget page:

// Uses ref.watch(counterNotifierProvider) to reactively display the counter value
// Uses ref.read(counterNotifierProvider.notifier) in callbacks to call named methods
// Key takeaway in the comments: The difference from StateProvider is that instead of directly mutating state (ref.read(provider.notifier).state++), you call named methods on the notifier (ref.read(provider.notifier).increment()). This keeps your state-change logic inside the StateNotifier class rather than scattered across widgets.

// To test it, update main.dart to use StateNotifierProviderPage as the home widget.