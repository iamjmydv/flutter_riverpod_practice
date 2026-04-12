import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/1_Provider/provider_sample.dart';

class ProviderPage extends ConsumerWidget {
  const ProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerText1 = ref.watch(providerSample1);
    final providerText2 = ref.watch(providerSample2);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '* Provider Page *',
              style: TextStyle(fontSize: 48),
            ),
            Text(
              providerText1,
              style: TextStyle(fontSize: 28),
            ),
            Text(
              providerText2,
              style: TextStyle(fontSize: 28),
            ),
          ],
        ),
      ),
    );
  }
}
