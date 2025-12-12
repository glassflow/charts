# glassflow-etl

![Version: 0.5.0](https://img.shields.io/badge/Version-0.5.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.6.0](https://img.shields.io/badge/AppVersion-2.6.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Glassflow | <help@glassflow.dev> | <https://glassflow.dev> |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://glassflow.github.io/glassflow-etl-k8s-operator | glassflow-operator | 0.6.7 |
| https://nats-io.github.io/k8s/helm/charts/ | nats(nats) | 1.3.6 |
| https://glassflow.github.io/charts | postgresql(postgresql) | 0.1.6 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| api.env | list | `[]` |  |
| api.image.pullPolicy | string | `"IfNotPresent"` |  |
| api.image.repository | string | `"glassflow-etl-be"` |  |
| api.image.tag | string | `"v2.6.0"` |  |
| api.logLevel | string | `"info"` |  |
| api.replicas | int | `1` |  |
| api.resources.limits.cpu | string | `"250m"` |  |
| api.resources.limits.memory | string | `"200Mi"` |  |
| api.resources.requests.cpu | string | `"100m"` |  |
| api.resources.requests.memory | string | `"100Mi"` |  |
| api.service.port | int | `8081` |  |
| api.service.targetPort | int | `8081` |  |
| api.service.type | string | `"ClusterIP"` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `5` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| glassflow-operator.controllerManager.manager.image.pullPolicy | string | `"IfNotPresent"` |  |
| glassflow-operator.controllerManager.manager.image.repository | string | `"glassflow-etl-k8s-operator"` |  |
| glassflow-operator.controllerManager.manager.image.tag | string | `"v1.4.2"` |  |
| glassflow-operator.controllerManager.manager.resources.limits.cpu | string | `"500m"` |  |
| glassflow-operator.controllerManager.manager.resources.limits.memory | string | `"128Mi"` |  |
| glassflow-operator.controllerManager.manager.resources.requests.cpu | string | `"10m"` |  |
| glassflow-operator.controllerManager.manager.resources.requests.memory | string | `"64Mi"` |  |
| glassflow-operator.controllerManager.replicas | int | `1` |  |
| glassflow-operator.controllerManager.serviceAccount.annotations | object | `{}` |  |
| glassflow-operator.glassflowComponents.ingestor.affinity | object | `{}` |  |
| glassflow-operator.glassflowComponents.ingestor.image.repository | string | `"glassflow-etl-ingestor"` |  |
| glassflow-operator.glassflowComponents.ingestor.image.tag | string | `"v2.6.0"` |  |
| glassflow-operator.glassflowComponents.ingestor.logLevel | string | `"INFO"` |  |
| glassflow-operator.glassflowComponents.ingestor.resources.limits.cpu | string | `"500m"` |  |
| glassflow-operator.glassflowComponents.ingestor.resources.limits.memory | string | `"750Mi"` |  |
| glassflow-operator.glassflowComponents.ingestor.resources.requests.cpu | string | `"100m"` |  |
| glassflow-operator.glassflowComponents.ingestor.resources.requests.memory | string | `"100Mi"` |  |
| glassflow-operator.glassflowComponents.join.affinity | object | `{}` |  |
| glassflow-operator.glassflowComponents.join.image.repository | string | `"glassflow-etl-join"` |  |
| glassflow-operator.glassflowComponents.join.image.tag | string | `"v2.6.0"` |  |
| glassflow-operator.glassflowComponents.join.logLevel | string | `"INFO"` |  |
| glassflow-operator.glassflowComponents.join.resources.limits.cpu | string | `"500m"` |  |
| glassflow-operator.glassflowComponents.join.resources.limits.memory | string | `"750Mi"` |  |
| glassflow-operator.glassflowComponents.join.resources.requests.cpu | string | `"100m"` |  |
| glassflow-operator.glassflowComponents.join.resources.requests.memory | string | `"100Mi"` |  |
| glassflow-operator.glassflowComponents.sink.affinity | object | `{}` |  |
| glassflow-operator.glassflowComponents.sink.image.repository | string | `"glassflow-etl-sink"` |  |
| glassflow-operator.glassflowComponents.sink.image.tag | string | `"v2.6.0"` |  |
| glassflow-operator.glassflowComponents.sink.logLevel | string | `"INFO"` |  |
| glassflow-operator.glassflowComponents.sink.resources.limits.cpu | string | `"500m"` |  |
| glassflow-operator.glassflowComponents.sink.resources.limits.memory | string | `"1.5Gi"` |  |
| glassflow-operator.glassflowComponents.sink.resources.requests.cpu | string | `"100m"` |  |
| glassflow-operator.glassflowComponents.sink.resources.requests.memory | string | `"100Mi"` |  |
| glassflow-operator.glassflowComponents.dedup.image.repository | string | `"glassflow-etl-dedup"` |  |
| glassflow-operator.glassflowComponents.dedup.image.tag | string | `"v2.6.0"` |  |
| glassflow-operator.glassflowComponents.dedup.logLevel | string | `"INFO"` |  |
| glassflow-operator.glassflowComponents.dedup.resources.limits.cpu | string | `"2000m"` |  |
| glassflow-operator.glassflowComponents.dedup.resources.limits.memory | string | `"4Gi"` |  |
| glassflow-operator.glassflowComponents.dedup.resources.requests.cpu | string | `"1000m"` |  |
| glassflow-operator.glassflowComponents.dedup.resources.requests.memory | string | `"1Gi"` |  |
| glassflow-operator.glassflowComponents.dedup.storage.className | string | `""` |  |
| glassflow-operator.glassflowComponents.dedup.storage.size | string | `"40Gi"` |  |
| global.imageRegistry | string | `"ghcr.io/glassflow/"` |  |
| global.nats.stream.maxAge | string | `"24h"` |  |
| global.nats.stream.maxBytes | string | `"10GB"` |  |
| global.observability.logs.enabled | bool | `false` |  |
| global.observability.logs.exporter.otlp | object | `{}` |  |
| global.observability.metrics.enabled | bool | `true` |  |
| global.pipelines.namespace.auto | bool | `true` |  |
| global.pipelines.namespace.create | bool | `true` |  |
| global.pipelines.namespace.name | string | `"glassflow-pipelines"` |  |
| global.usageStats.enabled | bool | `true` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts | list | `[]` |  |
| ingress.ingressClassName | string | `""` |  |
| ingress.tls | list | `[]` |  |
| nats.config.cluster.enabled | bool | `true` |  |
| nats.config.cluster.port | int | `6222` |  |
| nats.config.cluster.replicas | int | `3` |  |
| nats.config.jetstream.enabled | bool | `true` |  |
| nats.config.jetstream.fileStore.dir | string | `"/data"` |  |
| nats.config.jetstream.fileStore.enabled | bool | `true` |  |
| nats.config.jetstream.fileStore.pvc.enabled | bool | `true` |  |
| nats.config.jetstream.fileStore.pvc.size | string | `"100Gi"` |  |
| nats.config.jetstream.fileStore.pvc.storageClassName | string | `""` |  |
| nats.config.jetstream.memoryStore.enabled | bool | `false` |  |
| nats.config.jetstream.memoryStore.maxSize | string | `"1Gi"` |  |
| nats.config.resources.limits.cpu | string | `"2000m"` |  |
| nats.config.resources.limits.memory | string | `"4Gi"` |  |
| nats.config.resources.requests.cpu | string | `"2000m"` |  |
| nats.config.resources.requests.memory | string | `"4Gi"` |  |
| nats.enabled | bool | `true` |  |
| natsPrometheusExporter.image.pullPolicy | string | `"IfNotPresent"` |  |
| natsPrometheusExporter.image.repository | string | `"natsio/prometheus-nats-exporter"` |  |
| natsPrometheusExporter.image.tag | string | `"0.17.3"` |  |
| natsPrometheusExporter.metrics.accstatz | bool | `true` |  |
| natsPrometheusExporter.metrics.connz | bool | `true` |  |
| natsPrometheusExporter.metrics.connz_detailed | bool | `true` |  |
| natsPrometheusExporter.metrics.gatewayz | bool | `true` |  |
| natsPrometheusExporter.metrics.jsz | bool | `true` |  |
| natsPrometheusExporter.metrics.leafz | bool | `true` |  |
| natsPrometheusExporter.metrics.routez | bool | `true` |  |
| natsPrometheusExporter.metrics.subz | bool | `true` |  |
| natsPrometheusExporter.metrics.varz | bool | `true` |  |
| natsPrometheusExporter.service.name | string | `"http"` |  |
| natsPrometheusExporter.service.port | int | `80` |  |
| natsPrometheusExporter.service.protocol | string | `"TCP"` |  |
| natsPrometheusExporter.service.targetPort | int | `7777` |  |
| natsPrometheusExporter.service.type | string | `"ClusterIP"` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
| ui.auth0.appBaseUrl | string | `"http://localhost:8080"` |  |
| ui.auth0.clientId | string | `""` |  |
| ui.auth0.clientSecret | string | `""` |  |
| ui.auth0.domain | string | `""` |  |
| ui.auth0.enabled | bool | `false` |  |
| ui.auth0.issuerBaseUrl | string | `""` |  |
| ui.auth0.profileRoute | string | `"/api/auth/me"` |  |
| ui.auth0.secret | string | `""` |  |
| ui.env | list | `[]` |  |
| ui.image.pullPolicy | string | `"IfNotPresent"` |  |
| ui.image.repository | string | `"glassflow-etl-fe"` |  |
| ui.image.tag | string | `"v2.6.0"` |  |
| ui.kafkaGateway.enabled | bool | `true` |  |
| ui.kafkaGateway.image.pullPolicy | string | `"IfNotPresent"` |  |
| ui.kafkaGateway.image.repository | string | `"kafka-kerberos-gateway"` |  |
| ui.kafkaGateway.image.tag | string | `"latest"` |  |
| ui.kafkaGateway.port | int | `8082` |  |
| ui.kafkaGateway.resources.limits.cpu | string | `"200m"` |  |
| ui.kafkaGateway.resources.limits.memory | string | `"256Mi"` |  |
| ui.kafkaGateway.resources.requests.cpu | string | `"50m"` |  |
| ui.kafkaGateway.resources.requests.memory | string | `"128Mi"` |  |
| ui.logLevel | string | `"info"` |  |
| ui.replicas | int | `1` |  |
| ui.resources.limits.cpu | string | `"200m"` |  |
| ui.resources.limits.memory | string | `"1Gi"` |  |
| ui.resources.requests.cpu | string | `"100m"` |  |
| ui.resources.requests.memory | string | `"512Mi"` |  |
| ui.service.port | int | `8080` |  |
| ui.service.targetPort | int | `8080` |  |
| ui.service.type | string | `"ClusterIP"` |  |

