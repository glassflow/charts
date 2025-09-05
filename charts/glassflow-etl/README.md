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

## Setting up the ingress 
By default the `values.yaml` does not configure public access to glassflow installation. To enable public access to the installed glassflow, you can enable ingress by updating the `values.yaml` as follows:
```yaml
ingress:
  # Enable or disable ingress
  # Set to true to expose the application externally
  enabled: true  
  # Ingress class name (required for Kubernetes 1.18+)
  # Example: "nginx", "traefik", "istio"
  ingressClassName: "nginx"

  # Annotations for the ingress resource
  # Useful for SSL termination, rate limiting, etc.
  annotations: {}
  # Host configurations for the ingress  
  hosts: 
  - host: "glassflow.example.com"
    paths:
    - path: "/"
      pathType: Prefix
      serviceName: "glassflow-ui"
      servicePort: 8080
    - path: "/api/v1"
      pathType: Prefix
      serviceName: "glassflow-api"
      servicePort: 8081
  tls: []
```
For more details, please refer to the [installation docs](https://docs.glassflow.dev/installation/self-host/kubernetes-helm)

## Configuration

The following table lists the configurable parameters of the chart and their default values.

### Global Settings

| Parameter | Description | Default |
|-----------|-------------|---------|
| `global.imageRegistry` | Global image registry (prepended to all image repositories) | `""` |

### API Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `api.replicas` | Number of API replicas | `1` |
| `api.image.repository` | API image repository | `ghcr.io/glassflow/glassflow-etl-be` |
| `api.image.tag` | API image tag | `glassflow-cloud` |
| `api.image.pullPolicy` | API image pull policy | `Always` |
| `api.resources.requests.memory` | API memory requests | `"100Mi"` |
| `api.resources.requests.cpu` | API CPU requests | `"100m"` |
| `api.resources.limits.memory` | API memory limits | `"200Mi"` |
| `api.resources.limits.cpu` | API CPU limits | `"250m"` |
| `api.config.logLevel` | API log level | `"INFO"` |
| `api.service.type` | API service type | `ClusterIP` |
| `api.service.port` | API service port | `8080` |
| `api.service.targetPort` | API service target port | `8080` |

### UI Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `ui.replicas` | Number of UI replicas | `1` |
| `ui.image.repository` | UI image repository | `ghcr.io/glassflow/glassflow-etl-fe` |
| `ui.image.tag` | UI image tag | `glassflow-cloud` |
| `ui.image.pullPolicy` | UI image pull policy | `Always` |
| `ui.resources.requests.memory` | UI memory requests | `"512Mi"` |
| `ui.resources.requests.cpu` | UI CPU requests | `"100m"` |
| `ui.resources.limits.memory` | UI memory limits | `"1Gi"` |
| `ui.resources.limits.cpu` | UI CPU limits | `"200m"` |
| `ui.service.type` | UI service type | `ClusterIP` |
| `ui.service.port` | UI service port | `8080` |
| `ui.service.targetPort` | UI service target port | `8080` |

### GlassFlow Operator Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `glassflow-operator.controllerManager.replicas` | Number of operator replicas | `1` |
| `glassflow-operator.controllerManager.manager.image.repository` | Operator image repository | `ghcr.io/glassflow/glassflow-etl-k8s-operator` |
| `glassflow-operator.controllerManager.manager.image.tag` | Operator image tag | `main` |
| `glassflow-operator.controllerManager.manager.image.pullPolicy` | Operator image pull policy | `Always` |
| `glassflow-operator.controllerManager.manager.resources.limits.cpu` | Operator CPU limits | `500m` |
| `glassflow-operator.controllerManager.manager.resources.limits.memory` | Operator memory limits | `128Mi` |
| `glassflow-operator.controllerManager.manager.resources.requests.cpu` | Operator CPU requests | `10m` |
| `glassflow-operator.controllerManager.manager.resources.requests.memory` | Operator memory requests | `64Mi` |
| `glassflow-operator.controllerManager.serviceAccount.annotations` | Service account annotations | `{}` |
| `glassflow-operator.nats.address` | NATS address for operator connection | `""` (defaults to `{{ .Release.Name }}-nats.{{ .Release.Namespace }}.svc.cluster.local`) |
| `glassflow-operator.nats.componentAddress` | NATS component address for operator | `""` (defaults to NATS address) |
| `glassflow-operator.metricsService.ports[0].name` | Metrics service port name | `https` |
| `glassflow-operator.metricsService.ports[0].port` | Metrics service port | `8443` |
| `glassflow-operator.metricsService.ports[0].protocol` | Metrics service protocol | `TCP` |
| `glassflow-operator.metricsService.ports[0].targetPort` | Metrics service target port | `8443` |
| `glassflow-operator.metricsService.type` | Metrics service type | `ClusterIP` |

### NATS Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `nats.enabled` | Enable NATS deployment | `true` |
| `nats.config.cluster.enabled` | Enable NATS clustering | `true` |
| `nats.config.cluster.port` | NATS cluster port | `6222` |
| `nats.config.cluster.replicas` | Number of NATS replicas (min 2 for JetStream) | `3` |
| `nats.config.jetstream.enabled` | Enable JetStream | `true` |
| `nats.config.jetstream.memoryStore.enabled` | Enable memory storage for JetStream | `false` |
| `nats.config.jetstream.memoryStore.maxSize` | Maximum size of memory store | `1Gi` |
| `nats.config.jetstream.fileStore.enabled` | Enable file storage for JetStream | `true` |
| `nats.config.jetstream.fileStore.dir` | File store directory | `/data` |
| `nats.config.jetstream.fileStore.pvc.enabled` | Enable PVC for file store | `true` |
| `nats.config.jetstream.fileStore.pvc.size` | Size of file store PVC | `100Gi` |
| `nats.config.jetstream.fileStore.pvc.storageClassName` | Storage class for file store | `""` |
| `nats.config.resources.requests.memory` | NATS memory requests | `"2Gi"` |
| `nats.config.resources.requests.cpu` | NATS CPU requests | `"500m"` |
| `nats.config.resources.limits.memory` | NATS memory limits | `"4Gi"` |
| `nats.config.resources.limits.cpu` | NATS CPU limits | `"1000m"` |

### Ingress Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `ingress.enabled` | Enable ingress | `false` |
| `ingress.ingressClassName` | Ingress class name | `""` |
| `ingress.annotations` | Ingress annotations | `{}` |
| `ingress.hosts` | Ingress hosts | `[]` |
| `ingress.tls` | Ingress TLS configuration | `[]` |

### Security Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `podSecurityContext` | Pod security context | `{}` |
| `securityContext` | Container security context | `{}` |

### Service Account Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `serviceAccount.create` | Create service account | `true` |
| `serviceAccount.automount` | Automount API credentials | `true` |
| `serviceAccount.annotations` | Service account annotations | `{}` |
| `serviceAccount.name` | Service account name | `""` |

### Pod Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `podAnnotations` | Pod annotations | `{}` |
| `podLabels` | Pod labels | `{}` |
| `nodeSelector` | Node selector for main pods | `{}` |
| `tolerations` | Pod tolerations | `[]` |
| `affinity` | Pod affinity rules | `{}` |

### Autoscaling Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `autoscaling.enabled` | Enable autoscaling | `false` |
| `autoscaling.minReplicas` | Minimum replicas | `1` |
| `autoscaling.maxReplicas` | Maximum replicas | `5` |
| `autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization | `80` |

### Volume Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `volumes` | Additional volumes | `[]` |
| `volumeMounts` | Additional volume mounts | `[]` |

## Customizing the Installation

You can customize the installation by providing a values file:

```bash
helm install glassflow-etl glassflow-etl-0.1.0.tgz --namespace <namespace> -f custom-values.yaml
```

Or by setting individual values:

```bash
helm install glassflow-etl glassflow-etl-0.1.0.tgz --namespace <namespace> --set ui.replicas=2
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

3. NATS Configuration:
   - When JetStream is enabled, cluster replicas must be 2 or higher
   - File storage is recommended for production use
   - Memory store can be used for development/testing

4. Resource Management:
   - Adjust resource requests and limits based on your workload
   - Monitor resource usage and adjust accordingly
   - Consider using autoscaling for production workloads

5. Service Configuration:
   - UI and API services are configured independently
   - Each component can have different service types and ports
   - Global image registry and pull secrets apply to all components