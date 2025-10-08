# Glassflow Helm Chart

```bash
helm repo add glassflow https://glassflow.github.io/charts
helm repo update
# Install glassflow-etl
helm install glassflow glassflow/glassflow-etl --create-namespace --namespace glassflow
```