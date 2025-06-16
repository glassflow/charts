# Glassflow ETL Helm Chart

This Helm chart deploys the Glassflow ETL application on Kubernetes.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- NATS Helm repository
- Storage Class that supports ReadWriteOnce (RWO) for NATS JetStream

## Installation

### Option 1: Using the packaged chart

1. Add the NATS Helm repository:
```bash
helm repo add nats https://nats-io.github.io/k8s/helm/charts/
helm repo update
```

2. Install the chart:

To an existing namespace:
```bash
helm install glassflow-etl glassflow-etl-0.1.0.tgz --namespace <namespace>
```

To a new namespace (will be created automatically):
```bash
helm install glassflow-etl glassflow-etl-0.1.0.tgz --namespace <namespace> --create-namespace
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

To an existing namespace:
```bash
helm install glassflow-etl . --namespace <namespace>
```

To a new namespace (will be created automatically):
```bash
helm install glassflow-etl . --namespace <namespace> --create-namespace
```

## Configuration

The following table lists the configurable parameters of the chart and their default values.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `nats.enabled` | Enable NATS | `true` |
| `nats.jetstream.enabled` | Enable JetStream | `true` |
| `nats.jetstream.fileStorage.enabled` | Enable file storage for JetStream | `true` |
| `nats.jetstream.fileStorage.size` | Size of JetStream storage | `20Gi` |
| `nats.jetstream.fileStorage.storageClass` | Storage class for JetStream | `standard-rwo` |
| `nats.config.cluster.enabled` | Enable NATS clustering | `false` |
| `nats.config.cluster.replicas` | Number of NATS replicas (min 2 for JetStream) | `3` |
| `ui.replicaCount` | Number of UI pods | `1` |
| `app.replicaCount` | Number of app pods | `1` |
| `ingress.enabled` | Enable ingress | `true` |
| `ingress.hosts[0].host` | Ingress hostname | `etl.glassflow.xyz` |

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