# `application/` — Riverpod Wiring

> The **glue**. This layer holds the dependency-injection graph and the providers that the UI actually watches. No business rules, no HTTP.

---

## What lives here

```
application/
└── providers/      — every Riverpod provider the app exposes
```

A pragmatic codebase keeps the entire DI graph in one folder so you can see at a glance *what depends on what*.

---

## The two kinds of providers here

| Kind | Example | Job |
|---|---|---|
| **DI providers** | `weatherApiServiceProvider`, `weatherRepositoryProvider`, `getWeatherUseCaseProvider` | "Given the dependencies, build a `WeatherRepository`." Pure construction. |
| **State providers** | `cityQueryProvider`, `weatherFutureProvider` | What the UI watches. They wire state + use cases together. |

Read top-down, the DI providers form a dependency chain:

```
weatherApiServiceProvider     ← base: builds the API service
       │
       ▼
weatherRepositoryProvider     ← uses the api service
       │
       ▼
getWeatherUseCaseProvider     ← uses the repository
       │
       ▼
weatherFutureProvider         ← watched by the UI, calls the use case
```

---

## The rules

| ✅ DO | ❌ DON'T |
|---|---|
| Import from `domain/` and `data/` | Import from `presentation/` |
| Hold `Provider<T>` construction logic | Hold business rules (those go in use cases) |
| Override providers in tests / scopes | Fetch JSON, parse JSON, hit the network |

The application layer is the ONLY layer that knows about Riverpod AND about the concrete data-layer impls. It is the wiring harness that binds the two while keeping them separate.

---

## Why a separate "application" layer at all?

Because DI doesn't belong to the domain (the domain is pure Dart) and it doesn't belong to the data layer (data types shouldn't know about Riverpod). Putting it here:

1. Keeps domain + data portable.
2. Makes testing easy — override one provider, the rest of the graph is untouched.
3. Gives a single folder to read when you're onboarding.

---

## See also

- [`providers/README.md`](providers/README.md) — file-by-file breakdown
- [../DATA_FLOW.md](../DATA_FLOW.md) — how a request threads through this layer
