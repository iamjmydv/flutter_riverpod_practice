import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/practice_provider/provider/consumer_widget_provider.dart';

/// By subclassing [ConsumerWidget] instead of [StatelessWidget],
/// our widget's build method gets an extra ref object (of type [WidgetRef]) that we can use to watch our provider.
///Using ConsumerWidget is the most common option and the one you should choose most of the time.
///
///

// 1. widget class now extends [ConsumerWidget]
class UsingConsumerWidgetPage extends ConsumerWidget {
  const UsingConsumerWidgetPage({super.key});

  @override
  // 2. build method has an extra [WidgetRef] argument
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. use ref.watch() to get the value of the provider
    final text = ref.watch(helloWorldProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('-- ConsumerWidget --'),
            Text(
              text,
              style: TextStyle(fontSize: 48),
            ),
          ],
        ),
      ),
    );
  }
}
