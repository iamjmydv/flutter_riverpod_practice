# `data/` — Implements the Domain

> This is where the domain contracts are fulfilled with real (or fake) plumbing: HTTP clients, JSON parsing, local storage, caches.

The data layer is the **only** place the outside world touches the app. If you want to change from REST to GraphQL, from Dio to http, from no-cache to SharedPreferences — this is the folder you edit. Nothing else changes.

---

## What lives here

```
data/
├── data_sources/   — talks to the outside world (HTTP, DB, file system)
│   └── remote/     — network sources
│   (local/)        — caches, DB, prefs (add when needed)
├── models/         — JSON ↔ Entity translation
└── repositories/   — wires data_sources + models to fulfill domain contracts
```

| Folder | Job | Knows about |
|---|---|---|
| **data_sources/** | Raw I/O — returns `Map<String, dynamic>` or similar | HTTP, SQL, file system |
| **models/** | Translates JSON → Entity | Both JSON shape AND the Entity |
| **repositories/** | Implements the domain contract | data_sources + models |

---

## The dependency direction

```
data/repositories/*_impl.dart   ──implements──▶  domain/repositories/*.dart
         │
         ├──uses──▶ data/data_sources/   (fetching)
         └──uses──▶ data/models/         (parsing)
```

`data/` imports from `domain/`. `domain/` NEVER imports from `data/`. If your IDE shows an arrow the other way, something is wrong.

---

## The split that enables fake-data demos

This project runs with no backend because the data layer is split:

| File | Job |
|---|---|
| `data_sources/remote/weather_api_service.dart` | Abstract — "here's the HTTP surface" |
| `data_sources/remote/weather_api_service_impl.dart` | Concrete — returns hardcoded JSON today, Dio tomorrow |
| `repositories/weather_repository_impl.dart` | Calls the service, feeds JSON into the Model, returns an Entity |

To go live: swap the body of `WeatherApiServiceImpl.getWeather`. Everything above it keeps working.

---

## See also

- [../DATA_FLOW.md](../DATA_FLOW.md) — full request walk-through
- [../domain/README.md](../domain/README.md) — the contracts this layer implements
