import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/practice_provider/provider/consumer_widget_provider.dart';

class UsingConsumerPage extends StatelessWidget {
  const UsingConsumerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Add a Consumer
    return Consumer(
      // 2. specify the builder and obtain a WidgetRef
      // (_, WidgetRef ref, _) <- this can work as-well
      builder: (context, WidgetRef ref, child) {
        // 3. use ref.watch() to get the value of the provider
        final worldWord = ref.watch(helloWorldProvider);
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('--- Consumer ---'),
                Text(
                  worldWord,
                  style: TextStyle(fontSize: 48),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
