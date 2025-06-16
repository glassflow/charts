# Glassflow Helm Charts

This repository contains the official Helm charts for Glassflow components.

## Charts

| Chart | Description |
|-------|-------------|
| [glassflow-etl](./charts/glassflow-etl) | Glassflow ETL component for data processing and transformation |

## Usage

### Add the Helm Repository

```bash
helm repo add glassflow https://glassflow.github.io/charts
helm repo update
```

### Install a Chart

```bash
# First, add the NATS repository (required for dependencies)
helm repo add nats https://nats-io.github.io/k8s/helm/charts/
helm repo update

# Install glassflow-etl (this will also install NATS)
helm install my-etl glassflow/glassflow-etl --create-namespace
```

### List Available Charts

```bash
helm search repo glassflow
```

## Development

### Prerequisites

- [Helm](https://helm.sh/docs/intro/install/) (v3.2.0+)
- [Kubernetes](https://kubernetes.io/docs/setup/) cluster

### Local Development

1. Clone the repository:
```bash
git clone https://github.com/glassflow/charts.git
cd charts
```

2. Add dependencies:
```bash
helm dependency update charts/glassflow-etl
```

3. Test the chart:
```bash
helm lint charts/glassflow-etl
helm template my-etl charts/glassflow-etl
```

## Contributing

We welcome contributions to our Helm charts. Please see our [contributing guide](CONTRIBUTING.md) for more details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. 