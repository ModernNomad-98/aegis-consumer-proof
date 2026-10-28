# Checklist

A small static checklist published with GitHub Pages. It is plain HTML, CSS and JavaScript: no build step, no framework, no external requests.

## Files

| Path | Purpose |
| --- | --- |
| `site/index.html` | Page structure |
| `site/app.js` | State, storage, rendering and event handlers |
| `site/styles.css` | Presentation |
| `.github/workflows/pages.yml` | Manual two-mode workflow: build (no publish) and deploy (publish retained bytes only) |

## Behaviour

- The first visit shows three neutral sample items. No fourth item appears.
- New labels are trimmed. Empty labels are rejected. A duplicate of an existing trimmed label is rejected case-sensitively.
- Items can be toggled complete and back, and deleted. IDs stay stable across toggles, deletes, reloads and new items.
- State is saved in `localStorage` under `checklist.state.v1` as:

  ```json
  {"items":[{"id":"seed-1","label":"Plan the week","completed":false}]}
  ```

  The shape is strict: one `items` array, each item with exactly `id`, `label` and `completed`. There is no version field.
- If the stored value is not valid JSON or does not match that shape, it is **left unchanged** at the same key and shown on the page. The page enters a recoverable error state that survives reloads. Only the named **Reset saved data** action clears the key and restores the three sample items; the reset is confirmed on the page.
- An operation addressed to an unknown or stale item ID makes no change and reports a visible error.

## Workflow

The workflow is `workflow_dispatch` only; it has no push trigger.

- `mode=build` assembles and gates the three files, writes a manifest, and uploads the Pages artifact. It does not deploy.
- `mode=deploy` reads the committed retained bytes at `docs/evidence/releases/<release>/site/` and `manifest.txt` from the same commit, verifies every byte, LF count, SHA-256 and the aggregate, and only then publishes. A missing or mismatched retained bundle fails closed.

No deployment is performed by committing content.
