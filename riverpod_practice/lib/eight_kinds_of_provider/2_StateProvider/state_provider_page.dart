import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/2_StateProvider/state_provider_sample.dart';

class StateProviderPage extends ConsumerWidget {
  const StateProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterProvider = ref.watch(counterStateProvider);
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () => ref.read(counterStateProvider.notifier).state = 0,
        icon: Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),
        style: IconButton.styleFrom(backgroundColor: Colors.blue),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '* Counter StateProvider *',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () => ref.read(counterStateProvider.notifier).state++,
              child: Text('You Press the Button $counterProvider Times'),
            ),
            SizedBox(
              height: 48,
            ),
            Text(
              counterProvider.toString(),
              style: TextStyle(fontSize: 48),
            ),
          ],
        ),
      ),
    );
  }
}

//NOTE!: StateProvider is ideal for storing simple state variables, such as enums, strings, booleans, and numbers. 

// ref.read vs ref.watch serve different purposes:

// ref.watch (line 10) — Listens to the provider and rebuilds the widget whenever the value changes. 
//                       Used in the build method to keep the UI in sync with state.

// ref.read (line 22) — Reads the provider's value once, without listening. 
//                      Used inside callbacks like onPressed to perform an action (mutate state).

// Why ref.read here? The onPressed callback runs only when the button is tapped — it's a one-time event, 
// not something that needs to reactively rebuild. If you used ref.watch inside onPressed, 
// it would subscribe to the provider every time the button is pressed, which is wasteful and can cause bugs.

// The rule of thumb:

// Where	Use	Why
// Inside build	ref.watch	Rebuild UI on changes
// Inside callbacks (onPressed, onTap, etc.)	ref.read	Fire-and-forget action
// Line 10 uses ref.watch to display the counter value reactively. 
//Line 22 uses ref.read to modify the state in response to a tap — it doesn't need to listen, it just needs to write.
