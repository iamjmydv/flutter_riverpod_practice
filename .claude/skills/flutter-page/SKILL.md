---
name: flutter-page
description: Scaffold a new Flutter page with Riverpod ConsumerWidget boilerplate
argument-hint: <page_name> [description]
---

Create a new Flutter page using Riverpod's ConsumerWidget pattern.

## Arguments
- `$0` — The page name in PascalCase (e.g., `HomePage`, `SettingsPage`)
- Remaining arguments — Optional description of what the page should do

## Instructions

1. Create a new file in the appropriate directory under `riverpod_practice/lib/`
2. Use this boilerplate structure:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class {PageName} extends ConsumerWidget {
  const {PageName}({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('{Page Title}')),
      body: Center(
        child: Text('{PageName}'),
      ),
    );
  }
}
```

3. Use ConsumerWidget (not StatelessWidget) so Riverpod `ref` is available
4. Follow the naming conventions used in this project
5. If a description is provided, add relevant UI elements and providers based on it

Arguments: $ARGUMENTS
