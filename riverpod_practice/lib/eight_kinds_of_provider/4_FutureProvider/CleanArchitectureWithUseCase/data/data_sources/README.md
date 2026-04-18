# `data/data_sources/`

> The **edge** of the app — where bytes come in and go out.

A data source is the lowest-level "give me raw data" piece. It does not know about entities, business rules, or the UI. It returns whatever the underlying transport hands it (usually `Map<String, dynamic>` for JSON APIs, or raw rows for a database).

---

## Subfolders

```
data_sources/
├── remote/         — network (HTTP, WebSocket, GraphQL)
└── local/          — add when you need caching (DB, SharedPreferences, files)
```

This project only has `remote/` because the demo does not cache.

---

## Each data source is split into TWO files

| File | Purpose |
|---|---|
| `*_service.dart`        | **Abstract** class. Defines the surface. One method per endpoint. |
| `*_service_impl.dart`   | **Concrete** class. Real HTTP calls via Dio/http, OR fake JSON for demos/tests. |

### Why the split?

- Swap real ↔ fake with one line in [`../../application/providers/`](../../application/providers/README.md).
- Unit-test the repository against a fake that implements the abstract — no network.
- The abstract doubles as documentation: open the file, see every endpoint the app calls.

---

## What goes here — and what doesn't

| ✅ DO | ❌ DON'T |
|---|---|
| Call `dio.get(...)` / `http.get(...)` | Call `WeatherModel.fromJson` (that's the repository's job) |
| Throw framework exceptions (`DioException`) | Throw domain exceptions (`InvalidCityException`) |
| Return raw `Map<String, dynamic>` | Return `WeatherEntity` |
| Add query params, headers, auth tokens | Apply business validation |

Think: *"This file is one step above the TCP socket."*

---

## Where it fits in the flow

```
repository_impl  ──calls──▶  *_service (abstract)
                              ▲
                              │ (Riverpod picks)
                              │
                      *_service_impl   ← the only place that touches Dio/http
```

See [`remote/`](remote/) for this project's concrete files.
