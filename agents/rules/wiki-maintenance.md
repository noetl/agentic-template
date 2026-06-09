# Wiki Maintenance Rule

Documentation memory should move with code, not as a delayed cleanup.

Supported documentation systems:

- GitHub Wiki
- Confluence

Choose one as the primary home for each module/surface to avoid duplication drift.

## Rule 1: first touch coverage

If a module has no dedicated docs page and you introduce substantive behavior, create that page before merge.

## Rule 2: update docs with code

When public surface changes (API, config, schema, behavior), update docs in the same change set.

For GitHub Wiki pages, keep page links in `Home.md`/sidebar structures.

For Confluence pages, include stable page links in:

- the linked issue/ticket
- `sync/issues/` note for the change

## Rule 3: pointer bump check

When bumping submodule pointers in the meta-repo, verify docs coverage remains accurate for landed changes.

If the merged range changed public behavior and no doc update exists, stop and create/update docs before final pointer bump commit.