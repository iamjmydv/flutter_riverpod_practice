// 1. extend [ConsumerStatefulWidget]

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/practice_provider/provider/consumer_widget_provider.dart';

class UsingConsumerStatefulWidgetPage extends ConsumerStatefulWidget {
  const UsingConsumerStatefulWidgetPage({super.key});

  @override
  ConsumerState<UsingConsumerStatefulWidgetPage> createState() =>
      _UsingConsumerStatefulWidgetPage();
}

// 2. extend [ConsumerState]
class _UsingConsumerStatefulWidgetPage
    extends ConsumerState<UsingConsumerStatefulWidgetPage> {
  @override
  void initState() {
    super.initState();
    // 3. if needed, we can read the provider inside initState
    final helloWorld = ref.read(helloWorldProvider);
    print(helloWorld); // "Hello world"
  }

  @override
  Widget build(BuildContext context) {
    // 4. use ref.watch() to get the value of the provider
    final helloWorld = ref.watch(helloWorldProvider);
    return Text(helloWorld);
  }
}
