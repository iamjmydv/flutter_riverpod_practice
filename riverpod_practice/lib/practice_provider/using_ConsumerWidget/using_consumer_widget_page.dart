import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/practice_provider/using_ConsumerWidget/provider/consumer_widget_provider.dart';

/// By subclassing [ConsumerWidget] instead of [StatelessWidget],
/// our widget's build method gets an extra ref object (of type [WidgetRef]) that we can use to watch our provider.
///Using ConsumerWidget is the most common option and the one you should choose most of the time.
///
class UsingConsumerWidgetPage extends ConsumerWidget {
  const UsingConsumerWidgetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(helloWorld);
    return Scaffold(
      body: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 48),
        ),
      ),
    );
  }
}
