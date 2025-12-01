# postgresql

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 17](https://img.shields.io/badge/AppVersion-17-informational?style=flat-square)

A Helm chart for PostgreSQL database used by GlassFlow ETL

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Glassflow | <help@glassflow.dev> | <https://glassflow.dev> |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalArgs | list | `[]` |  |
| additionalVolumeMounts | list | `[]` |  |
| additionalVolumes | list | `[]` |  |
| affinity | object | `{}` |  |
| annotations | object | `{}` |  |
| auth.database | string | `"glassflow"` |  |
| auth.enabled | bool | `true` |  |
| auth.existingSecret.enabled | bool | `false` | Enable use of existing Kubernetes secret for authentication credentials. When enabled, the chart will use the existing secret instead of `auth.username` and `auth.password`. This is useful for production deployments where credentials should be managed externally (e.g., via external-secrets operator, Sealed Secrets, or manual secret creation). |
| auth.existingSecret.keys.databaseKey | string | `"database"` | Key name in the existing secret that contains the database name. If not provided or the key doesn't exist, the chart will fall back to `auth.database`. |
| auth.existingSecret.keys.passwordKey | string | `"password"` | Key name in the existing secret that contains the PostgreSQL password. Required when `auth.existingSecret.enabled` is `true`. |
| auth.existingSecret.keys.usernameKey | string | `"username"` | Key name in the existing secret that contains the PostgreSQL username. Required when `auth.existingSecret.enabled` is `true`. |
| auth.existingSecret.name | string | `""` | Name of the existing Kubernetes secret to use for authentication. Required when `auth.existingSecret.enabled` is `true`. The secret must exist in the same namespace where the chart is deployed. Example: `kubectl create secret generic postgres-credentials --from-literal=username=myuser --from-literal=password=mypass --from-literal=database=mydb` |
| auth.password | string | `"glassflow@123"` | PostgreSQL password for the application user. Required when `auth.existingSecret.enabled` is `false`. |
| auth.username | string | `"glassflow"` | PostgreSQL username for the application user. Required when `auth.existingSecret.enabled` is `false`. |
| customLivenessProbe | object | `{}` |  |
| customReadinessProbe | object | `{}` |  |
| global.storageClass | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"postgres"` |  |
| image.tag | string | `"17-alpine"` |  |
| imagePullSecrets | list | `[]` |  |
| initContainers | list | `[]` |  |
| livenessProbe.enabled | bool | `true` |  |
| livenessProbe.failureThreshold | int | `6` |  |
| livenessProbe.initialDelaySeconds | int | `30` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| maxConnections | int | `100` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.dataDir | string | `"/var/lib/postgresql/data"` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `""` |  |
| persistence.mountPath | string | `"/var/lib/postgresql"` |  |
| persistence.size | string | `"20Gi"` |  |
| persistence.storageClass | string | `""` |  |
| persistence.subPath | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| priorityClassName | string | `""` |  |
| readinessProbe.enabled | bool | `true` |  |
| readinessProbe.failureThreshold | int | `6` |  |
| readinessProbe.initialDelaySeconds | int | `5` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"1000m"` |  |
| resources.limits.memory | string | `"2Gi"` |  |
| resources.requests.cpu | string | `"250m"` |  |
| resources.requests.memory | string | `"512Mi"` |  |
| securityContext | object | `{}` |  |
| service.annotations | object | `{}` |  |
| service.port | int | `5432` |  |
| service.targetPort | int | `5432` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
| topologySpreadConstraints | list | `[]` |  |

