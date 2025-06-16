# Glassflow Helm Charts Repository

This is the Helm charts repository for Glassflow components. This repository is automatically generated and should not be modified directly.

## Available Charts

| Chart | Description | Version |
|-------|-------------|---------|
| [glassflow-etl](https://github.com/glassflow/charts/tree/main/charts/glassflow-etl) | Glassflow ETL component for data processing and transformation | [![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://github.com/glassflow/charts/tree/main/charts/glassflow-etl) |

## Usage

Add the Glassflow Helm repository:

```bash
helm repo add glassflow https://glassflow.github.io/charts
helm repo update
```

Install a chart:

```bash
# First, add the NATS repository (required for dependencies)
helm repo add nats https://nats-io.github.io/k8s/helm/charts/
helm repo update

# Install glassflow-etl
helm install my-etl glassflow/glassflow-etl --create-namespace
```

## Repository Structure

This repository contains the following files:
- `index.yaml`: The repository index file
- `glassflow-etl-0.1.0.tgz`: The packaged Helm chart

## Support

For issues, feature requests, or questions, please visit our [GitHub repository](https://github.com/glassflow/charts).
