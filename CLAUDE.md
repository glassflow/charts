# charts

Helm charts for deploying GlassFlow components on Kubernetes.

## Repo layout

```
charts/
  glassflow-etl/        # Main GlassFlow ETL chart (operator + pipeline components)
  pgbouncer/            # PgBouncer connection pooler chart
  postgresql/           # PostgreSQL chart
ct.yaml                 # Chart testing config
```

## Commands

```bash
make lint               # helm lint all charts
helm lint charts/<chart-name>          # Lint a single chart
helm template charts/<chart-name>      # Render templates locally (useful for debugging)
```

## Key conventions

- `Chart.yaml` — chart name, version, appVersion. Both `version` (chart) and `appVersion` (deployed image tag) must be updated on release.
- `values.yaml` — default values; keep all configurable fields here with comments.
- Template files go in `templates/`; helpers in `templates/_helpers.tpl`.
- Don't commit `Chart.lock` or `values.yaml.new` — these are generated artifacts.

## Boundaries with other repos

- Packages `clickhouse-etl` pipeline components
- Packages `glassflow-etl-k8s-operator`
- Deployed by `cli/` via embedded Helm operations

## Release process

Chart versions are bumped on each release. The `cli` embeds or references chart versions — coordinate chart version bumps with CLI releases.

## Git & PR conventions

- Branch naming follows Linear ticket ID: `ETL-XYZ` or `username/ETL-XYZ-description`
- Reviewed by: Petr, Pablo, Kiran
- No `Co-Authored-By: Claude` or AI attribution in commits/PRs

## Domain context

For glossary, architecture diagrams, customer personas, and cross-repo workflows see the shared context repo (sibling directory):

```
../glassflow-agent-context/
  domain/glossary.md              # Key terms and definitions
  domain/deployment-topology.md   # How components fit together in prod
  workflows/release-process.md    # Release and versioning process
  workflows/linear-tickets.md     # Ticket → branch → PR flow
```

Load these on demand when doing design work, writing PR descriptions, or when domain terminology is ambiguous. Don't load them for routine code tasks.
