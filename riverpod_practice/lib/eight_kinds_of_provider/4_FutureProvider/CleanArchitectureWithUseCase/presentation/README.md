# `presentation/` — The UI

> Flutter widgets and nothing more. The presentation layer is the thinnest layer in a clean architecture — it should barely contain any logic.

---

## What lives here

```
presentation/
├── pages/          — full screens (ConsumerWidget / ConsumerStatefulWidget)
├── widgets/        — reusable UI pieces   (add when you need them)
├── controllers/    — page-level state     (add when you need them)
```

This demo only has `pages/` — one screen, one concern.

---

## The only thing the UI is allowed to import

```dart
import '../application/providers/...';
```

That's it. Not `data/`, not `domain/` directly. **Everything the UI needs arrives through a Riverpod provider in `application/providers/`.**

> "But `weather.city` is a `WeatherEntity` from the domain layer!"
>
> Yes — it's **transitively** available because the provider yields an `AsyncValue<WeatherEntity>`. The widget doesn't `import` the entity file. This is subtle, but it means the UI depends only on provider *types* — not on the data-layer concretions behind them.

---

## Rules for widget code

| ✅ DO | ❌ DON'T |
|---|---|
| `ref.watch(someProvider)` | Instantiate a repository, use case, or API service |
| Display loading / error / data | Validate user input (use-case's job) |
| Call `ref.read(x.notifier).state = ...` on user actions | Parse JSON |
| Handle routing, animation, gestures | Contain business rules |

When you feel the urge to "just do this one thing in the widget" — stop and ask whether it belongs in a use case or a controller.

---

## See also

- [`pages/README.md`](pages/README.md) — current pages
- [../DATA_FLOW.md](../DATA_FLOW.md) — where the UI sits in the request flow
