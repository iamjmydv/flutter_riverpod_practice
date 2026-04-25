# Clean Architecture with ChangeNotifierProvider

This folder applies a 3-layer Clean Architecture (domain / data / presentation) to the shopping cart sample, with **ChangeNotifierProvider** as the state management primitive.

The scenario is identical to the flat version one folder up, so you can compare side-by-side how the same feature looks before and after applying Clean Architecture.

---

## Folder Structure

```
6_ChangeNotifierProvider/CleanArchitecture/
├── domain/                                  (pure Dart, no dependencies)
│   ├── cart_item_entity.dart                — core business object
│   └── cart_repository.dart                 — abstract interface
│
├── data/                                    (implements domain contracts)
│   ├── cart_item_model.dart                 — JSON serialization/deserialization
│   └── cart_repository_impl.dart            — concrete API implementation
│
└── presentation/                            (UI + state)
    ├── providers/
    │   ├── cart_repository_provider.dart    — repository provider (DI)
    │   ├── cart_notifier.dart               — ChangeNotifier (cart logic)
    │   └── cart_provider.dart               — ChangeNotifierProvider definition
    └── change_notifier_provider_page.dart   — page widget
```

---

## The 3 Layers

### 1. Domain Layer (The "What")
- **Entity** — `CartItemEntity` (pure Dart class)
- **Repository Interface** — `CartRepository` (abstract)

ZERO dependencies on Flutter, Riverpod, or any package.

### 2. Data Layer (The "How")
- **Model** — `CartItemModel` extends `CartItemEntity` with JSON helpers
- **Repository Implementation** — `CartRepositoryImpl` (simulated network call)

### 3. Presentation Layer (The "Glue" + The "Look")
- **`providers/cart_repository_provider.dart`** — types as `CartRepository`, returns `CartRepositoryImpl()`
- **`providers/cart_notifier.dart`** — `ChangeNotifier` that holds cart state and calls the repository
- **`providers/cart_provider.dart`** — `cartProvider` injects the repository into the notifier
- **`change_notifier_provider_page.dart`** — watches `cartProvider` and renders the cart UI

---

## Dependency Rule

```
presentation  -->  domain  <--  data
   (UI + state)    (core)       (API)
```

- `domain/` has ZERO imports from other layers
- `data/` only imports from `domain/`
- `presentation/` imports from `domain/` and `data/`
- `presentation/providers/` is where dependency injection lives — the page imports only from there

---

## ChangeNotifierProvider vs Notifier / StateNotifier

| Feature                  | ChangeNotifierProvider             | StateNotifier / Notifier           |
|--------------------------|------------------------------------|------------------------------------|
| `ref.watch()` returns    | The notifier OBJECT                | The STATE                          |
| State mutability         | Mutable (in-place changes)         | Immutable (replace whole state)    |
| Update mechanism         | `notifyListeners()`                | Reassign `state`                   |
| Best for                 | Migrating from `provider` package  | New projects                       |

> Riverpod docs recommend `Notifier` / `AsyncNotifier` for new projects. `ChangeNotifierProvider` is kept mainly as a migration path from the legacy `provider` package — that's why it lives in `flutter_riverpod/legacy.dart`.

---

## How to Run

Update `main.dart` to import this page instead of the flat one:

```dart
import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/CleanArchitecture/presentation/change_notifier_provider_page.dart';
```

The `ChangeNotifierProviderPage` class name is the same — only the import path changes.

---

## Why Clean Architecture for a Cart?

In the flat version, `sampleProducts` is hardcoded inside the page widget. That's fine for a demo, but in real apps the catalog comes from an API, a database, or a remote config.

By moving the catalog behind a `CartRepository` abstraction:

- The notifier and the UI don't care WHERE products come from
- Swapping `CartRepositoryImpl` (fake list) for a real REST/GraphQL/Firestore implementation is a one-line change in `presentation/providers/cart_repository_provider.dart`
- The notifier can be unit-tested by passing a fake `CartRepository` directly to its constructor — no Flutter, no widgets, no Riverpod required
