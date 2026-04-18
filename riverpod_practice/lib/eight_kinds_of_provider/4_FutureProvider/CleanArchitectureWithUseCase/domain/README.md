# `domain/` — The Business Core

> Pure Dart. No Flutter, no Riverpod, no Dio, no JSON. If you copy this folder into a server or CLI, it compiles.

The domain is the **innermost** layer of clean architecture. It depends on nothing. Every other layer depends on it.

---

## What lives here

```
domain/
├── entities/       — core business objects (plain data classes)
├── repositories/   — abstract contracts (what data is needed)
└── usecases/       — single user actions (business rules live here)
```

| Folder | Job | Analogy |
|---|---|---|
| **entities** | Define the shape of the business object | "What IS a Weather?" |
| **repositories** | Declare WHAT data operations exist | "I need a way to get weather" |
| **usecases** | One action at a time, with rules | "Get weather — but validate first" |

---

## The one rule

> Nothing in `domain/` may import from `data/`, `application/`, or `presentation/`.

Check any file in this folder. The imports will only reference **other files inside `domain/`**. That's the point — keep it pure.

---

## Why keep it pure?

1. **Unit tests are trivial** — no Riverpod container, no mocked HTTP, no widget tree.
2. **Business rules survive rewrites** — swap Flutter for a different UI, swap Riverpod for Bloc, swap Dio for http — the domain doesn't care.
3. **Onboarding is faster** — a new dev reads the domain to learn what the product *does*, without wading through framework code.

---

## See also

- [../DATA_FLOW.md](../DATA_FLOW.md) — full request walk-through
- [../USE_CASE.md](../USE_CASE.md) — why use cases exist
