# Platform Data Access Boundary

A corollary to the [Execution model](execution-model.md)'s
"workers are atomic compute blocks" shape.

## The rule

Platform-owned data is accessible through the owning service API only. Workers,
background jobs, system playbooks, CLIs, gateways, and clients must not bypass
the service boundary to read or write platform tables directly.

Examples of platform-owned data include:

- event/history logs
- command queues
- execution records
- catalogs or registries
- credential/keychain stores
- runtime registration and heartbeat state
- any future table or durable store owned by the platform service

The rule covers both reads and writes. A worker queries catalog entries via the
service API, not `SELECT` against the catalog table. A system worker emits
events via the service API, not direct inserts into the event log.

## Why

1. **Connection pool isolation** — workers scale on backlog. If every worker
   holds database connections, worker scale can starve the service API itself.
2. **Sharding readiness** — the owning service can route by execution, tenant,
   region, or shard without teaching every worker about topology.
3. **Single point of consistency** — migrations, audit logging, RBAC,
   validation, and credential scrubbing stay centralized.

## External subsystem exception

The rule applies to platform-owned data. It does not apply to external systems
that a workflow intentionally integrates with, such as tenant databases,
third-party APIs, identity providers, object stores, or notification systems.

When a workflow step acts as a client to an external system, it may use the
appropriate tool directly, authenticated by an explicit credential reference.
When a workflow step manipulates platform state, it must go through the owning
service API.

## Decision tree

1. Does this step touch platform-owned data?
   - Yes: use the owning service API.
   - No: use the appropriate external-system tool.
2. Does the service API expose the endpoint the workflow needs?
   - Yes: use it.
   - No: add or track the endpoint before shipping the workflow.
3. Does the call require authentication?
   - Yes: use an explicit service-account or credential reference.

## Coordination with other rules

- [`execution-model.md`](execution-model.md) establishes the gateway / worker /
  workflow / state / event-log shape.
- [`observability.md`](observability.md) requires spans, metrics, and
  correlation identifiers on new internal API endpoints.
- [`issue-tracking.md`](issue-tracking.md) covers tracking missing endpoints or
  multi-session follow-up.
