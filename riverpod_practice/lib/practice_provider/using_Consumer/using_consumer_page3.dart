import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/practice_provider/provider/consumer_widget_provider.dart';

class UsingConsumerPage3 extends StatelessWidget {
  const UsingConsumerPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('CONSUMER WIDGET --- PAGE 3'),
          Consumer(
            builder: (context, WidgetRef ref, child) {
              final text = ref.watch(helloWorldProvider);
              return Text(
                text,
                style: TextStyle(fontSize: 38),
                textAlign: TextAlign.center,
              );
            },
          ),
        ],
      ),
    );
  }
}
