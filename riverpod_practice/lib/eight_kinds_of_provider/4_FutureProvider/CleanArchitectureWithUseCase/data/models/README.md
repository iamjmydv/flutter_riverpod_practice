# `data/models/`

> The **bridge** between raw JSON and domain entities. The ONLY place JSON keys appear in the app.

---

## The role in one sentence

A Model takes a `Map<String, dynamic>` (from the API) and hands back something the domain understands — usually a subclass of the Entity with a `fromJson` factory.

```dart
class WeatherModel extends WeatherEntity {
  const WeatherModel({required super.city, required super.temperature, required super.condition});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['city'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      condition: json['condition'] as String,
    );
  }
}
```

---

## Why extend the Entity?

Two benefits:

1. **Single source of truth for the shape.** The Entity owns the fields; the Model reuses them.
2. **The repository returns the Model as an Entity.** The rest of the app never sees the Model type — JSON is sealed inside the data layer.

```
API  →  Map<String, dynamic>  →  WeatherModel.fromJson  →  WeatherEntity  →  Use case / UI
                                       ▲
                                       │
                                   ONLY HERE does JSON appear
```

---

## What goes here

| ✅ DO | ❌ DON'T |
|---|---|
| `fromJson(Map<String, dynamic>)` | Business rules (validation, unit conversion) |
| `toJson()` (for caching / sending) | HTTP calls |
| Defensive casts, null-coalescing for wonky APIs | Flutter or Riverpod imports |
| Mapping nested / weirdly-named JSON to clean fields | Multiple responsibilities |

When the backend renames a field, **this file** is the only one that breaks. That's the whole point.

---

## Current models

- [`weather_model.dart`](weather_model.dart) — parses `{ city, temperature, condition }`.
