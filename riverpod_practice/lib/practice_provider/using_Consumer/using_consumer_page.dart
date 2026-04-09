import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/practice_provider/provider/consumer_widget_provider.dart';

class UsingConsumerPage extends StatelessWidget {
  const UsingConsumerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
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
