# Entity vs Model — What's the Difference?

> `WeatherEntity` and `WeatherModel` look almost identical. So why have both?

Short answer: they look the same **today** because the API and your app happen to use the same field names. The split exists for **the day they stop matching** — and in real projects, that day always comes.

Let's walk through a concrete scenario.

---

## The setup

Your app has 3 files that use weather data:

1. **`future_provider_page.dart`** — shows the temperature on screen
2. **`weather_repository.dart`** — fetches weather from the API
3. **`future_provider_sample.dart`** — the provider that connects them

All 3 read `weatherModel.temperature`.

---

## Day 1: Everything works

Your API returns:

```json
{ "city": "London", "temperature": 22.5, "condition": "Sunny" }
```

Your class (the flat version, one folder up):

```dart
// weather_model.dart
class WeatherModel {
  final String city;
  final double temperature;
  final String condition;
}
```

Your page:

```dart
Text('${weatherModel.temperature}°C')  // works
```

---

## Day 30: The backend team changes the API

They send you an email: *"Hey, we renamed `temperature` to `temp_celsius`."*

Now the API returns:

```json
{ "city": "London", "temp_celsius": 22.5, "condition": "Sunny" }
```

### Without the split (only `WeatherModel` exists — your flat folder)

You have to rename the field on `WeatherModel` to match the API:

```dart
class WeatherModel {
  final double temp_celsius;  // renamed to match the API
}
```

Now **every file that touches `WeatherModel` breaks**:

- `future_provider_page.dart` → `weatherModel.temperature` no longer exists → **compile error**
- `future_provider_sample.dart` → also broken
- Any test, any widget, any helper that read `temperature` → **all broken**

You have to hunt through your whole app and rename every `weatherModel.temperature` → `weatherModel.temp_celsius`.

Your UI now also speaks the API's language — `temp_celsius` is an ugly name to use in widgets, but you're stuck with it.

---

### With the split (`WeatherEntity` + `WeatherModel` — this CleanArchitecture folder)

**`WeatherEntity` stays the same** — it's your app's *internal* name for the field:

```dart
// domain/weather_entity.dart
class WeatherEntity {
  final String city;
  final double temperature;  // unchanged!
  final String condition;
}
```

**Only `WeatherModel` changes** — it translates the API's field name into the entity's field name:

```dart
// data/weather_model.dart
class WeatherModel extends WeatherEntity {
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['city'],
      temperature: json['temp_celsius'],  // ← only this line changes
      condition: json['condition'],
    );
  }
}
```

Your page? **Untouched** — still reads `weather.temperature`.
Your provider? **Untouched.**
Your tests? **Untouched.**

You changed **one line in one file** (`WeatherModel.fromJson`).

---

## The mental model

Think of `WeatherModel` as a **translator** sitting at the border between the API and your app:

```
[ API world ]  →  WeatherModel  →  [ Your app world (WeatherEntity) ]
"temp_celsius"     (translator)     "temperature"
```

- The **API** can call the field whatever it wants (`temp_celsius`, `temp_c`, `tempC`...)
- Your **app** always uses the entity's name (`temperature`)
- `WeatherModel` is the only thing that knows both names

When the API changes its naming, you only retrain the translator (`WeatherModel.fromJson`). The rest of your app doesn't even notice.

---

## Quick comparison

| Thing | `WeatherEntity` (domain) | `WeatherModel` (data) |
|---|---|---|
| Purpose | Represent the business concept | Represent how the API sends/receives it |
| Knows about JSON? | ❌ No | ✅ Yes (`fromJson`/`toJson`) |
| Knows about HTTP/DB? | ❌ Never | ✅ Allowed |
| Who imports it? | Anyone | Only the data layer |
| Changes when… | Business rules change | The API contract changes |

---

## Rule of thumb

> If a field only exists because of how the API/DB sends data → put it on the **Model**.
> If a field is part of what the thing **fundamentally is** → put it on the **Entity**.
