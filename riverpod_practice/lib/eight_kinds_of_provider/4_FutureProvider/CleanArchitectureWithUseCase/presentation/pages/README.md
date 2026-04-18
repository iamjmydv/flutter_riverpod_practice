# `presentation/pages/`

> Full-screen widgets — one file per route.

Pages are the top-level entry points of the UI. They are `ConsumerWidget` (stateless) or `ConsumerStatefulWidget` (when they own controllers like `TextEditingController`).

---

## Current pages

| File | Shows |
|---|---|
| [`future_provider_page.dart`](future_provider_page.dart) | City search + `AsyncValue.when(...)` rendering weather, error, or a spinner. |

---

## The page pattern used here

```dart
class FutureProviderPage extends ConsumerStatefulWidget { ... }

class _FutureProviderPageState extends ConsumerState<FutureProviderPage> {
  // Local widget state (e.g. TextEditingController) lives in the State.
  // App-wide state lives in providers.

  @override
  Widget build(BuildContext context) {
    final weatherAsync = ref.watch(weatherFutureProvider);

    return weatherAsync.when(
      loading: () => CircularProgressIndicator(),
      error: (err, _) => Text('Error: $err'),
      data: (weather) => WeatherCard(weather),
    );
  }
}
```

Three things to notice:

1. The page **watches one provider**. That provider handles the whole pipeline behind it.
2. `ref.read(x.notifier).state = ...` is used for *events* (e.g. search). `ref.watch` is used for *data*.
3. The `.when(...)` pattern is idiomatic for `AsyncValue` — it forces you to handle loading, error, and data branches.

---

## Where to split

A page grows. When it does:

- Extract presentational pieces into `../widgets/`.
- Extract non-trivial state management into a controller (typically a `Notifier` in `application/providers/`).
- Keep the page file focused on layout + wiring `ref.watch` / `ref.read` to those pieces.

---

## What NOT to do

- ❌ Call a repository, API service, or use case directly.
- ❌ Instantiate `WeatherRepositoryImpl()` by hand — always go through a provider.
- ❌ Put validation or unit conversion in `onPressed` callbacks — those belong in use cases.
