---
name: clean-feature
description: Generate a clean architecture folder structure for a new feature with domain, data, application, and presentation layers
argument-hint: <feature_name> [description]
---

Generate a complete clean architecture folder structure for a new feature.

## Arguments
- `$0` — The feature name in snake_case (e.g., `user_profile`, `shopping_cart`)
- Remaining arguments — Optional description of what the feature should do

## Instructions

Create the following folder structure under `riverpod_practice/lib/`:

```
features/{feature_name}/
├── domain/
│   ├── {feature_name}_entity.dart        — Pure Dart entity class with copyWith
│   └── {feature_name}_repository.dart    — Abstract repository interface
├── data/
│   ├── {feature_name}_model.dart         — Extends entity with fromJson/toJson
│   └── {feature_name}_repository_impl.dart — Concrete repository implementation
├── application/
│   ├── {feature_name}_repository_provider.dart — Repository provider (DI)
│   ├── {feature_name}_notifier.dart      — AsyncNotifier with build() and methods
│   └── {feature_name}_provider.dart      — AsyncNotifierProvider definition
└── presentation/
    └── {feature_name}_page.dart          — ConsumerWidget page with .when() pattern
```

## Rules

1. **domain/** — Pure Dart only. No Flutter, no Riverpod imports. Entity has `copyWith`.
2. **data/** — Model extends entity with `fromJson`/`toJson`. Repository implements the abstract interface with simulated API calls (Future.delayed).
3. **application/** — Repository provider typed as ABSTRACT interface, creates CONCRETE impl. AsyncNotifier uses `build()` for initial fetch and `AsyncValue.guard()` for updates.
4. **presentation/** — ConsumerWidget uses `ref.watch()` and `.when(loading, error, data)` pattern.
5. **Dependency rule**: presentation -> application -> domain <- data
6. Follow the same patterns used in `8_AsyncNotifierProvider/` of this project.
7. If a description is provided, tailor the entity fields, repository methods, and UI to match the described feature.

Arguments: $ARGUMENTS
