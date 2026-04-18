# `domain/entities/`

> The **core business objects**. The nouns of your app.

An entity is what the rest of the app sees when it talks about a "Weather", a "User", an "Order". It carries data and — when it makes sense — invariants. Nothing else.

---

## What goes in here

- Pure Dart classes
- Final fields, `const` constructors when possible
- Domain-level invariants (e.g. `isStale`, `isExpired`)

## What does NOT go in here

- `fromJson` / `toJson`        → belongs in [`data/models/`](../../data/models/README.md)
- Annotations like `@JsonSerializable`, `@freezed` with codegen for JSON → data layer
- `copyWith` tied to JSON keys → data layer
- Any import from `data/`, `application/`, `presentation/`, Flutter, Riverpod, or Dio

A well-written entity should compile on a **server** without changes.

---

## Why not just use the Model everywhere?

Because JSON changes. The day the backend renames `temp` → `temperature_celsius`, you DO NOT want that change rippling into your widgets, your use cases, and your tests.

- **Entity** = stable shape the app agrees on.
- **Model** = bridge between JSON and the entity; the rename stays in ONE file.

See [../../data/models/README.md](../../data/models/README.md) for the matching piece.

---

## Current entity

- [`weather_entity.dart`](weather_entity.dart) — `{ city, temperature, condition }`
