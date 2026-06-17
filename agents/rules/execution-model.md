# Execution Model

Before designing any feature, integration, deployment change, or operational
fix, verify that the proposal respects the platform boundary.

## The shape

- **Gateway/service edge = gatekeeper.** Handles session auth,
  authorization, routing, protocol concerns, subscription delivery, and
  request correlation. It does not reach around the owning service to satisfy
  client data requests.
- **Workers = atomic compute blocks.** Claim work, hydrate inputs, execute one
  unit of compute, write outputs, emit boundary events, and release the slot.
- **Workflows/playbooks = ephemeral blueprints.** Control flow and policy are
  invoked on demand and replayable from recorded state.
- **Shared state transport = explicit state vehicle.** State between blocks is
  reconstructable from durable history.
- **Event/history log = source of truth.** Append-only history records what
  happened and supports replay.

## Data access rule

Any business data touch happens inside a workflow/playbook step under that
workflow's policy. Clients do not reach databases directly. Gateways do not
reach around service APIs to satisfy client requests.

For platform-owned data, the stricter companion rule applies:
[`data-access-boundary.md`](data-access-boundary.md).

## Secrets and credentials rule

Business-logic credentials belong in a credential store or keychain and are
referenced by alias from workflow steps. Do not add third-party API tokens,
tenant database DSNs, signing keys, or encryption keys to worker/gateway env
vars as hidden business logic.

Credentialed steps must declare auth explicitly; see
[`no-default-connection.md`](no-default-connection.md).

## Callback / hook rule

A block should not hold a worker slot while waiting for an external operation
that takes more than a few seconds. Capture the correlation ID and callback
subject/webhook, release the slot, and resume later from recorded state.

## Observability rule

Every new boundary should be traceable with spans, metrics, and correlation
IDs. See [`observability.md`](observability.md).

## Practical rule

If a proposal moves data-touch logic into a gateway/client layer, introduces
hidden long-lived state, or holds a worker/process slot across an external
wait without replay semantics, redesign before implementation.
