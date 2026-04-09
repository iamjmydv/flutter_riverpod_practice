import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/practice_provider/provider/consumer_widget_provider.dart';

///In this case, the "ref" object is one of the Consumer's builder arguments,
///and we can use it to watch the value of the provider.
///This works, but it's more verbose than the previous solution.

class UsingConsumerPage2 extends StatelessWidget {
  const UsingConsumerPage2({super.key});

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
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text('Consumer Page 2'),
            centerTitle: true,
            foregroundColor: Colors.white,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('--- Consumer Page 2---'),
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
