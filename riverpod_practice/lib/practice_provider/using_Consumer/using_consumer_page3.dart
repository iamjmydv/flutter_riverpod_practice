import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsingConsumerPage3 extends StatelessWidget {
  const UsingConsumerPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('CONSUMER WIDGET --- PAGE 3'),
          Consumer(
            builder: (context, WidgetRef ref, child) {
              return Text(
                'Consumer Widget Sample on Page 3',
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
