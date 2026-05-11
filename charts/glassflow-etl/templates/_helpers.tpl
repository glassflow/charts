{{/*
Expand the name of the chart.
*/}}
{{- define "glassflow-etl.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "glassflow-etl.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "glassflow-etl.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "glassflow-etl.labels" -}}
helm.sh/chart: {{ include "glassflow-etl.chart" . }}
{{ include "glassflow-etl.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "glassflow-etl.selectorLabels" -}}
app.kubernetes.io/name: {{ include "glassflow-etl.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "glassflow-etl.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "glassflow-etl.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the usage stats service account to use
*/}}
{{- define "glassflow-etl.usageStatsServiceAccountName" -}}
{{- include "glassflow-etl.fullname" . }}-usage-stats
{{- end }}

{{/*
Validate observability config. Fails the install with a clear error when an
internal subchart is requested without its parent signal enabled.
Invoked unconditionally from otel-collector-configmap.yaml (and any other
template) so misconfigurations are caught even when the surrounding template
itself doesn't render.
*/}}
{{- define "glassflow-etl.observability.validate" -}}
{{- if and .Values.global.observability.metrics.internal.enabled (not .Values.global.observability.metrics.enabled) -}}
{{- fail "global.observability.metrics.internal.enabled requires global.observability.metrics.enabled=true" -}}
{{- end -}}
{{- if and .Values.global.observability.logs.internal.enabled (not .Values.global.observability.logs.enabled) -}}
{{- fail "global.observability.logs.internal.enabled requires global.observability.logs.enabled=true" -}}
{{- end -}}
{{- end }}

{{/*
DNS name of the bundled VictoriaMetrics service (subchart-managed).
*/}}
{{- define "glassflow-etl.internalVMService" -}}
{{ .Release.Name }}-victoria-metrics-single-server
{{- end }}

{{/*
DNS name of the bundled VictoriaLogs service (subchart-managed).
*/}}
{{- define "glassflow-etl.internalVLService" -}}
{{ .Release.Name }}-victoria-logs-single-server
{{- end }}
