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
| `global.imageRegistry` | Global image registry (prepended to all image repositories) | `"ghcr.io/glassflow/"` |
| `global.observability.metrics.enabled` | Enable metrics collection | `true` |
| `global.observability.logs.enabled` | Enable logs export | `false` |
| `global.observability.logs.exporter.otlp` | OTLP exporter configuration for logs | `{}` |
| `global.nats.address` | NATS address (defaults to `{{ .Release.Name }}-nats.{{ .Release.Namespace }}.svc.cluster.local` if not specified) | `""` |
| `global.nats.stream.maxAge` | Maximum age for NATS streams | `24h` |
| `global.nats.stream.maxBytes` | Maximum bytes for NATS streams | `25GB` |
| `global.pipelines.namespace.auto` | When true, operator creates per-pipeline namespaces (pipeline-<id>) | `true` |
| `global.pipelines.namespace.name` | Fixed namespace to deploy all pipelines into (when auto is false) | `glassflow-pipelines` |
| `global.pipelines.namespace.create` | When auto is false, Helm can optionally create the namespace | `true` |
| `global.usageStats.enabled` | Enable usage statistics collection | `true` |

### API Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `api.replicas` | Number of API replicas | `1` |
| `api.logLevel` | API log level | `"INFO"` |
| `api.image.repository` | API image repository | `glassflow-etl-be` |
| `api.image.tag` | API image tag | `v2.4.0` |
| `api.image.pullPolicy` | API image pull policy | `IfNotPresent` |
| `api.resources.requests.memory` | API memory requests | `"100Mi"` |
| `api.resources.requests.cpu` | API CPU requests | `"100m"` |
| `api.resources.limits.memory` | API memory limits | `"200Mi"` |
| `api.resources.limits.cpu` | API CPU limits | `"250m"` |
| `api.service.type` | API service type | `ClusterIP` |
| `api.service.port` | API service port | `8081` |
| `api.service.targetPort` | API service target port | `8081` |
| `api.env` | Additional environment variables (array of objects with `name` and `value` keys) | `[]` |

### UI Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `ui.replicas` | Number of UI replicas | `1` |
| `ui.image.repository` | UI image repository | `glassflow-etl-fe` |
| `ui.image.tag` | UI image tag | `v2.4.0` |
| `ui.image.pullPolicy` | UI image pull policy | `IfNotPresent` |
| `ui.resources.requests.memory` | UI memory requests | `"512Mi"` |
| `ui.resources.requests.cpu` | UI CPU requests | `"100m"` |
| `ui.resources.limits.memory` | UI memory limits | `"1Gi"` |
| `ui.resources.limits.cpu` | UI CPU limits | `"200m"` |
| `ui.service.type` | UI service type | `ClusterIP` |
| `ui.service.port` | UI service port | `8080` |
| `ui.service.targetPort` | UI service target port | `8080` |
| `ui.env` | Additional environment variables (array of objects with `name` and `value` keys) | `[]` |
| `ui.kafkaGateway.enabled` | Enable Kafka Kerberos Gateway sidecar | `true` |
| `ui.kafkaGateway.image.repository` | Kafka Gateway image repository | `kafka-kerberos-gateway` |
| `ui.kafkaGateway.image.tag` | Kafka Gateway image tag | `latest` |
| `ui.kafkaGateway.image.pullPolicy` | Kafka Gateway image pull policy | `IfNotPresent` |
| `ui.kafkaGateway.resources.requests.memory` | Kafka Gateway memory requests | `"128Mi"` |
| `ui.kafkaGateway.resources.requests.cpu` | Kafka Gateway CPU requests | `"50m"` |
| `ui.kafkaGateway.resources.limits.memory` | Kafka Gateway memory limits | `"256Mi"` |
| `ui.kafkaGateway.resources.limits.cpu` | Kafka Gateway CPU limits | `"200m"` |
| `ui.kafkaGateway.port` | Kafka Gateway port (internal to pod) | `8082` |

### GlassFlow Operator Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `glassflow-operator.controllerManager.replicas` | Number of operator replicas | `1` |
| `glassflow-operator.controllerManager.manager.image.repository` | Operator image repository | `glassflow-etl-k8s-operator` |
| `glassflow-operator.controllerManager.manager.image.tag` | Operator image tag | `v1.3.0` |
| `glassflow-operator.controllerManager.manager.image.pullPolicy` | Operator image pull policy | `IfNotPresent` |
| `glassflow-operator.controllerManager.manager.resources.limits.cpu` | Operator CPU limits | `500m` |
| `glassflow-operator.controllerManager.manager.resources.limits.memory` | Operator memory limits | `128Mi` |
| `glassflow-operator.controllerManager.manager.resources.requests.cpu` | Operator CPU requests | `10m` |
| `glassflow-operator.controllerManager.manager.resources.requests.memory` | Operator memory requests | `64Mi` |
| `glassflow-operator.controllerManager.serviceAccount.annotations` | Service account annotations | `{}` |
| `glassflow-operator.glassflowComponents.ingestor.image.repository` | Ingestor component image repository | `glassflow-etl-ingestor` |
| `glassflow-operator.glassflowComponents.ingestor.image.tag` | Ingestor component image tag | `v2.4.0` |
| `glassflow-operator.glassflowComponents.ingestor.logLevel` | Ingestor component log level | `"INFO"` |
| `glassflow-operator.glassflowComponents.ingestor.resources.requests.cpu` | Ingestor CPU requests | `1000m` |
| `glassflow-operator.glassflowComponents.ingestor.resources.requests.memory` | Ingestor memory requests | `1Gi` |
| `glassflow-operator.glassflowComponents.ingestor.resources.limits.cpu` | Ingestor CPU limits | `1500m` |
| `glassflow-operator.glassflowComponents.ingestor.resources.limits.memory` | Ingestor memory limits | `1.5Gi` |
| `glassflow-operator.glassflowComponents.ingestor.affinity` | Node affinity for ingestor component | `{}` |
| `glassflow-operator.glassflowComponents.join.image.repository` | Join component image repository | `glassflow-etl-join` |
| `glassflow-operator.glassflowComponents.join.image.tag` | Join component image tag | `v2.4.0` |
| `glassflow-operator.glassflowComponents.join.logLevel` | Join component log level | `"INFO"` |
| `glassflow-operator.glassflowComponents.join.resources.requests.cpu` | Join CPU requests | `1000m` |
| `glassflow-operator.glassflowComponents.join.resources.requests.memory` | Join memory requests | `1Gi` |
| `glassflow-operator.glassflowComponents.join.resources.limits.cpu` | Join CPU limits | `1500m` |
| `glassflow-operator.glassflowComponents.join.resources.limits.memory` | Join memory limits | `1.5Gi` |
| `glassflow-operator.glassflowComponents.join.affinity` | Node affinity for join component | `{}` |
| `glassflow-operator.glassflowComponents.sink.image.repository` | Sink component image repository | `glassflow-etl-sink` |
| `glassflow-operator.glassflowComponents.sink.image.tag` | Sink component image tag | `v2.4.0` |
| `glassflow-operator.glassflowComponents.sink.logLevel` | Sink component log level | `"INFO"` |
| `glassflow-operator.glassflowComponents.sink.resources.requests.cpu` | Sink CPU requests | `1000m` |
| `glassflow-operator.glassflowComponents.sink.resources.requests.memory` | Sink memory requests | `1Gi` |
| `glassflow-operator.glassflowComponents.sink.resources.limits.cpu` | Sink CPU limits | `1500m` |
| `glassflow-operator.glassflowComponents.sink.resources.limits.memory` | Sink memory limits | `1.5Gi` |
| `glassflow-operator.glassflowComponents.sink.affinity` | Node affinity for sink component | `{}` |

### NATS Prometheus Exporter Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `natsPrometheusExporter.image.repository` | NATS Prometheus exporter image repository | `natsio/prometheus-nats-exporter` |
| `natsPrometheusExporter.image.tag` | NATS Prometheus exporter image tag | `0.17.3` |
| `natsPrometheusExporter.image.pullPolicy` | NATS Prometheus exporter image pull policy | `IfNotPresent` |
| `natsPrometheusExporter.metrics.accstatz` | Enable account statistics metrics | `true` |
| `natsPrometheusExporter.metrics.connz` | Enable connection metrics | `true` |
| `natsPrometheusExporter.metrics.connz_detailed` | Enable detailed connection metrics | `true` |
| `natsPrometheusExporter.metrics.jsz` | Enable JetStream metrics | `true` |
| `natsPrometheusExporter.metrics.gatewayz` | Enable gateway metrics | `true` |
| `natsPrometheusExporter.metrics.leafz` | Enable leaf node metrics | `true` |
| `natsPrometheusExporter.metrics.routez` | Enable route metrics | `true` |
| `natsPrometheusExporter.metrics.subz` | Enable subscription metrics | `true` |
| `natsPrometheusExporter.metrics.varz` | Enable variable metrics | `true` |
| `natsPrometheusExporter.service.type` | NATS Prometheus exporter service type | `ClusterIP` |
| `natsPrometheusExporter.service.port` | NATS Prometheus exporter service port | `80` |
| `natsPrometheusExporter.service.targetPort` | NATS Prometheus exporter service target port | `7777` |
| `natsPrometheusExporter.service.protocol` | NATS Prometheus exporter service protocol | `TCP` |
| `natsPrometheusExporter.service.name` | NATS Prometheus exporter service name | `http` |

**Note:** The NATS Prometheus exporter is automatically enabled when `global.observability.metrics.enabled` is `true`.

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

6. Environment Variables:
   - Environment variables for API and UI components must be specified as an array of objects with `name` and `value` keys
   - Example format:
     ```yaml
     api:
       env:
         - name: GLASSFLOW_LOG_LEVEL
           value: "DEBUG"
     ```

7. Observability:
   - Metrics collection is enabled by default (`global.observability.metrics.enabled: true`)
   - When metrics are enabled, the NATS Prometheus exporter is automatically deployed
   - Logs export is disabled by default (`global.observability.logs.enabled: false`)
   - OTLP exporter configuration can be customized via `global.observability.logs.exporter.otlp`

8. Pipeline Namespaces:
   - By default, the operator creates per-pipeline namespaces (pipeline-<id>)
   - This can be disabled by setting `global.pipelines.namespace.auto: false`
   - When auto is disabled, all pipelines are deployed to a fixed namespace specified by `global.pipelines.namespace.name`

9. Kafka Kerberos Gateway:
   - The UI component includes an optional Kafka Kerberos Gateway sidecar for connecting to Kerberos-secured Kafka clusters
   - The gateway is enabled by default (`ui.kafkaGateway.enabled: true`)
   - The gateway runs on port 8082 within the UI pod
   - The `KAFKA_GATEWAY_URL` environment variable is automatically set for the sidecar when the gateway is enabled