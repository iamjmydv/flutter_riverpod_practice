---
name: provider-sample
description: Create a new Riverpod provider sample with separated files for model, repository, provider, and page
argument-hint: <provider_type> <topic> [description]
---

Create a new Riverpod provider sample with proper separation of concerns.

## Arguments
- `$0` — The provider type. One of: `Provider`, `StateProvider`, `StateNotifierProvider`, `FutureProvider`, `StreamProvider`, `ChangeNotifierProvider`, `NotifierProvider`, `AsyncNotifierProvider`
- `$1` — The topic/name for the sample (e.g., `weather`, `counter`, `todo`)
- Remaining arguments — Optional description of the scenario

## Instructions

Create the following files based on the provider type:

### For sync providers (Provider, StateProvider, StateNotifierProvider, ChangeNotifierProvider, NotifierProvider):
```
{topic}_model.dart       — Data class
{topic}_notifier.dart    — Notifier/controller class (if applicable)
{provider_type}_sample.dart — Provider definition
{provider_type}_page.dart   — ConsumerWidget page
```

### For async providers (FutureProvider, StreamProvider, AsyncNotifierProvider):
```
{topic}_model.dart       — Data class
{topic}_repository.dart  — Repository with async methods
{provider_type}_sample.dart — Provider definitions (repository + main provider)
{provider_type}_page.dart   — ConsumerWidget page with .when() pattern
```

## Rules

1. Each file has ONE responsibility (separation of concerns)
2. Models are plain Dart classes
3. Repositories simulate API calls with `Future.delayed`
4. Pages use `ref.watch()` for reactive UI and `ref.read()` in callbacks
5. Async providers use `.when(loading, error, data)` pattern
6. Add clear comments explaining the provider type and key concepts
7. Follow the patterns used in `riverpod_practice/lib/eight_kinds_of_provider/`
8. Use a real-world scenario (not just a counter) to make the sample practical
9. If a description is provided, tailor the sample to match that scenario

Arguments: $ARGUMENTS
