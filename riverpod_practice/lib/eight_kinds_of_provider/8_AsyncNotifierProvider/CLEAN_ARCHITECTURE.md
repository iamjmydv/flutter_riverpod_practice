# Clean Architecture with Flutter Riverpod

## What is Clean Architecture?

Clean Architecture is a way to organize your code into **layers**, where each layer has a specific job. The main goal is **separation of concerns** — each file does ONE thing, and changes in one layer don't break others.

Think of it like a restaurant:
- **Domain** = The recipe (what food should taste like)
- **Data** = The kitchen (how the food is actually cooked)
- **Application** = The waiter (takes orders, delivers food)
- **Presentation** = The dining room (what the customer sees)

---

## Folder Structure

```
8_AsyncNotifierProvider/
├── domain/                              (pure Dart, no dependencies)
│   ├── user_profile_entity.dart         — core business object
│   └── user_profile_repository.dart     — abstract interface
│
├── data/                                (implements domain contracts)
│   ├── user_profile_model.dart          — JSON serialization/deserialization
│   └── user_profile_repository_impl.dart — concrete API implementation
│
├── application/                         (business logic + providers)
│   ├── user_profile_repository_provider.dart — repository provider (DI)
│   ├── user_profile_notifier.dart       — AsyncNotifier (state logic)
│   └── user_profile_provider.dart       — AsyncNotifierProvider definition
│
└── presentation/                        (UI only)
    └── async_notifier_provider_page.dart — page widget
```

---

## The 4 Layers Explained

### 1. Domain Layer (The "What")

> "What does our app need to do?"

This is the **core** of your app. It contains:
- **Entities** — Plain Dart classes that represent your data (no Flutter, no packages)
- **Repository Interfaces** — Abstract classes that define what operations are available

```dart
// domain/user_profile_entity.dart
class UserProfile {
  final String id;
  final String name;
  final String email;
  final String bio;
}
```

```dart
// domain/user_profile_repository.dart
abstract class UserProfileRepository {
  Future<UserProfile> fetchProfile();
  Future<UserProfile> updateProfile(UserProfile profile);
}
```

**Key rule**: This layer has ZERO dependencies on Flutter, Riverpod, or any external package. It's pure Dart. If you deleted every other folder, this layer would still compile.

**Why?** Because your business rules don't care if you use Firebase, REST API, or a local database. The "what" stays the same regardless of "how."

---

### 2. Data Layer (The "How")

> "How do we actually get and send the data?"

This layer **implements** the abstract repository from the domain layer:
- **Models** — Extend entities with serialization (fromJson/toJson)
- **Repository Implementation** — The actual API calls, database queries, etc.

```dart
// data/user_profile_model.dart
class UserProfileModel extends UserProfile {
  factory UserProfileModel.fromJson(Map<String, dynamic> json) { ... }
  Map<String, dynamic> toJson() { ... }
}
```

```dart
// data/user_profile_repository_impl.dart
class UserProfileRepositoryImpl implements UserProfileRepository {
  @override
  Future<UserProfile> fetchProfile() async {
    // Actual HTTP call, Firebase query, etc.
  }
}
```

**Key rule**: This layer knows about the domain (it implements its interfaces) but the domain does NOT know about this layer.

**Why?** If you switch from REST API to GraphQL, you only change files in `data/`. Nothing else breaks.

---

### 3. Application Layer (The "Glue")

> "How do we connect everything and manage state?"

This layer contains:
- **Providers** — Riverpod providers that wire dependencies together
- **Notifiers** — State management logic (AsyncNotifier, Notifier, etc.)

```dart
// application/user_profile_repository_provider.dart
// Typed as abstract (UserProfileRepository), creates concrete (Impl)
final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  return UserProfileRepositoryImpl(); // <-- change this ONE line to swap data source
});
```

```dart
// application/user_profile_notifier.dart
class UserProfileNotifier extends AsyncNotifier<UserProfile> {
  @override
  Future<UserProfile> build() async {
    final repository = ref.watch(userProfileRepositoryProvider);
    return repository.fetchProfile();
  }
}
```

```dart
// application/user_profile_provider.dart
final userProfileProvider =
    AsyncNotifierProvider<UserProfileNotifier, UserProfile>(() {
  return UserProfileNotifier();
});
```

**Key rule**: This is where Dependency Injection happens. The provider returns the ABSTRACT type but creates the CONCRETE implementation.

**Why?** This makes testing easy — just override the provider with a mock implementation.

---

### 4. Presentation Layer (The "Look")

> "What does the user see?"

This layer is ONLY about UI:
- **Pages/Screens** — ConsumerWidget that watch providers
- **Widgets** — Reusable UI components

```dart
// presentation/async_notifier_provider_page.dart
class AsyncNotifierProviderPage extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);
    return profileAsync.when(
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (profile) => Text(profile.name),
    );
  }
}
```

**Key rule**: The UI only imports from the `application/` layer. It has NO direct access to `data/` or `domain/`.

**Why?** If you redesign the entire UI, the business logic and data fetching remain untouched.

---

## Dependency Rule

The most important rule in Clean Architecture:

```
presentation  -->  application  -->  domain  <--  data
   (UI)            (state)         (core)       (API)
```

- **Arrows point inward** toward the domain
- **Inner layers never know about outer layers**
- `domain/` has ZERO imports from other layers
- `data/` only imports from `domain/`
- `application/` imports from `domain/` and `data/`
- `presentation/` only imports from `application/`

---

## Real-World Benefits

### Swapping Data Sources
Want to switch from a fake API to a real one?

```dart
// BEFORE (fake)
final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  return UserProfileRepositoryImpl(); // fake/simulated data
});

// AFTER (real)
final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  return RealApiUserProfileRepository(); // real HTTP calls
});
```

Only ONE file changes. Every other layer stays the same.

### Easy Testing
```dart
// In tests, override the provider with a mock
final container = ProviderContainer(
  overrides: [
    userProfileRepositoryProvider.overrideWithValue(MockUserProfileRepository()),
  ],
);
```

### Team Collaboration
- Frontend dev works on `presentation/`
- Backend dev works on `data/`
- State management dev works on `application/`
- Everyone agrees on `domain/` first

---

## Common Questions

### "Isn't this overkill for a small app?"
Yes! For a small app or a learning project, flat files are fine. Clean Architecture shines when:
- Multiple developers work on the same feature
- You need to swap data sources (e.g., local DB to cloud)
- You want testable, maintainable code at scale

### "Entity vs Model — what's the difference?"
- **Entity** (domain) = Pure data, no serialization, no dependencies
- **Model** (data) = Extends entity with fromJson/toJson for the API layer

### "Why abstract the repository?"
So that your business logic depends on a CONTRACT (what), not an IMPLEMENTATION (how). This lets you swap, mock, or test freely.

### "Where do I put utility/helper functions?"
- If it's pure logic (date formatting, validation) → `domain/`
- If it's Flutter-specific (colors, themes) → `presentation/`
- If it's data-related (API client, headers) → `data/`

---

## Summary

| Layer          | Contains                    | Depends On       | Job                      |
|----------------|-----------------------------|------------------|--------------------------|
| **domain**     | Entity, Abstract Repository | Nothing          | Define business rules    |
| **data**       | Model, Repository Impl      | domain           | Fetch/send data          |
| **application**| Providers, Notifiers         | domain, data     | Wire everything together |
| **presentation**| Pages, Widgets              | application      | Show UI to user          |

The golden rule: **depend on abstractions, not concretions.** That's it.
