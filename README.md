# Glassflow Helm Charts

This repository contains the official Helm charts for Glassflow components.

## Charts

| Chart | Description |
|-------|-------------|
| [glassflow-etl](./charts/glassflow-etl) | Glassflow ETL component for deduplication and joins of kafka streams to clickhouse |
| [postgresql](./charts/postgresql) | PostgreSQL database chart used by GlassFlow ETL as a dependency |

## Usage

### Add the Helm Repository

```bash
helm repo add glassflow https://glassflow.github.io/charts
helm repo update
```

### Install the Chart

```bash
# Install glassflow-etl (this will also install NATS and glassflow-operator charts)
helm install glassflow glassflow/glassflow-etl --create-namespace --namespace glassflow
```
This installs the GlassFlow Helm chart into the `glassflow` namespace. The `--create-namespace` flag ensures the namespace is created if it doesn’t already exist.


### List Available Charts

```bash
helm search repo glassflow
```
The output should be like: 
```
NAME                   	CHART VERSION	APP VERSION	DESCRIPTION                
glassflow/glassflow-etl	0.1.1        	1.1.12     	A Helm chart for Kubernetes
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