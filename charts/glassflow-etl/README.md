# Glassflow ETL Helm Chart

This Helm chart deploys the Glassflow ETL application on Kubernetes.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- NATS Helm repository
- Storage Class that supports ReadWriteOnce (RWO) for NATS JetStream

## Installation

### Option 1: Using the packaged chart
```bash
helm repo add glassflow https://glassflow.github.io/charts
helm repo update
# Install glassflow-etl
helm install glassflow glassflow/glassflow-etl
```

### Option 2: Using the chart source

1. Add the NATS Helm repository:
```bash
helm repo add nats https://nats-io.github.io/k8s/helm/charts/
helm repo update
```

2. Update the chart dependencies:
```bash
helm dependency update
```

3. Install the chart:

```bash
helm install glassflow-etl . --namespace <namespace> --create-namespace
```

## Configuration

The following table lists the configurable parameters of the chart and their default values.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `nats.enabled` | Enable NATS | `true` |
| `nats.config.jetstream.enabled` | Enable JetStream | `true` |
| `nats.config.jetstream.fileStorage.enabled` | Enable file storage for JetStream | `true` |
| `nats.config.jetstream.fileStorage.size` | Size of JetStream storage | `10Gi` |
| `nats.config.jetstream.fileStorage.storageClass` | Storage class for JetStream | `""` |
| `nats.config.cluster.enabled` | Enable NATS clustering | `false` |
| `nats.config.cluster.replicas` | Number of NATS replicas (min 2 for JetStream) | `3` |
| `nats.config.jetstream.memStorage.enabled` | Enable memory storage for JetStream | `false` |
| `ingress.enabled` | Enable ingress | `false` |

For more configuration options, see `values.yaml`.

## Customizing the Installation

You can customize the installation by providing a values file:

```bash
helm install glassflow-etl glassflow-etl-0.1.0.tgz --namespace <namespace> -f custom-values.yaml
```

Or by setting individual values:

```bash
helm install glassflow-etl glassflow-etl-0.1.0.tgz --namespace <namespace> --set ui.replicaCount=2
```

## Important Notes

1. For production deployments:
   - Ensure NATS JetStream is enabled with file storage
   - Configure appropriate resource limits
   - Set up proper authentication
   - Consider enabling NATS clustering for high availability

2. The application requires:
   - NATS server for message queuing
   - Storage for NATS JetStream persistence
   - Ingress controller for external access 