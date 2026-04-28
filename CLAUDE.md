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

The shared context repo lives at `../glassflow-agent-context/` (sibling directory). Read files from it when:

- **Implementing a feature or ticket** → read `../glassflow-agent-context/workflows/linear-tickets.md` before branching
- **Writing a PR description** → read `../glassflow-agent-context/prompts/pr-description.md`
- **Bumping chart versions for a release** → read `../glassflow-agent-context/workflows/release-process.md`
- **Domain terminology is ambiguous** → read `../glassflow-agent-context/domain/glossary.md`

Don't load these for routine bug fixes or code tasks — read the code directly instead.
