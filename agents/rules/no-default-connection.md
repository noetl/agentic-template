# No Default Connection

Every workflow step that touches a database, external API, object store, or
other credentialed resource must declare its auth reference explicitly. No
fallback. No default. No implicit connection.

## The rule

A step that uses a credentialed tool must include an `auth:` field. The value
can reference:

- a credential alias registered in the project credential store
- a keychain entry resolved at step execution time
- a secret reference resolved from a secret manager

The field name is `auth:` unless the owning project has explicitly documented a
different schema.

```yaml
# Correct: explicit auth reference
- step: query_users
  tool: postgres
  auth: "tenant_reporting_db"
  input:
    query: "SELECT * FROM users LIMIT 10"

# Wrong: relies on an ambient default
- step: query_users
  tool: postgres
  input:
    query: "SELECT * FROM users LIMIT 10"
```

If a required `auth:` field is missing, the worker or tool dispatcher must
reject the step with a clear error instead of falling back to environment-level
defaults, hardcoded DSNs, or ambient connection pools.

## Why

1. **Credential isolation** prevents cross-tenant or cross-environment leaks.
2. **E2E testability** improves because every fixture declares its dependencies.
3. **Audit and rotation** work because each execution records the credential
   alias it used.

## What this covers

- workflow/playbook YAML
- test fixtures
- system workflows
- any tool kind that requires credentials

## What this does not cover

- platform/runtime credentials for a service process itself, such as its own
  message-bus connection, database URL, or mTLS identity
- local-only tool kinds that do not touch remote or credentialed resources

## Review checklist

1. Search for credentialed tool kinds.
2. Verify each matching step has an explicit `auth:` field.
3. Verify the referenced alias exists in the expected credential store or test
   fixture setup.

## Coordination with other rules

- [`execution-model.md`](execution-model.md) says business-logic credentials
  live in a keychain or credential store and are referenced by alias.
- [`data-access-boundary.md`](data-access-boundary.md) says platform-owned data
  goes through the owning service API.
- [`deployment-validation.md`](deployment-validation.md) catches missing
  credential aliases during local validation.
