{{/*
Expand the name of the chart.
*/}}
{{- define "postgresql.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "postgresql.fullname" -}}
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
{{- define "postgresql.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "postgresql.labels" -}}
helm.sh/chart: {{ include "postgresql.chart" . }}
{{ include "postgresql.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "postgresql.selectorLabels" -}}
app.kubernetes.io/name: {{ include "postgresql.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "postgresql.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "postgresql.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the secret to use for authentication credentials
Returns existing secret name if enabled, otherwise returns connection secret name
*/}}
{{- define "postgresql.secretName" -}}
{{- if and .Values.auth.existingSecret.enabled .Values.auth.existingSecret.name }}
{{- .Values.auth.existingSecret.name }}
{{- else }}
{{- printf "%s-connection" (include "postgresql.fullname" .) }}
{{- end }}
{{- end }}

{{/*
PostgreSQL image
*/}}
{{- define "postgresql.image" -}}
{{- if .Values.global.imageRegistry }}
{{- $registry := .Values.global.imageRegistry | trimSuffix "/" }}
{{- printf "%s/%s:%s" $registry .Values.image.repository .Values.image.tag }}
{{- else }}
{{- printf "%s:%s" .Values.image.repository .Values.image.tag }}
{{- end }}
{{- end }}

{{/*
PostgreSQL environment variables
Official postgres image uses: POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_DB, PGDATA
*/}}
{{- define "postgresql.env" -}}
{{- $usingExistingSecret := and .Values.auth.existingSecret.enabled .Values.auth.existingSecret.name }}
{{- $secretName := include "postgresql.secretName" . }}
- name: POSTGRES_USER
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ if $usingExistingSecret }}{{ .Values.auth.existingSecret.keys.usernameKey | default "username" }}{{ else }}username{{ end }}
- name: POSTGRES_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ if $usingExistingSecret }}{{ .Values.auth.existingSecret.keys.passwordKey | default "password" }}{{ else }}password{{ end }}
- name: POSTGRES_DB
{{- if and $usingExistingSecret .Values.auth.existingSecret.keys.databaseKey }}
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .Values.auth.existingSecret.keys.databaseKey }}
{{- else }}
  value: {{ .Values.auth.database | default "glassflow" | quote }}
{{- end }}
- name: PGDATA
  value: {{ .Values.persistence.dataDir | quote }}
{{- end }}

{{/*
PostgreSQL connection URL template
Returns the connection URL format that can be used by parent charts
Format: postgresql://username:password@host:port/database
Note: Password should be retrieved from secret in parent chart
*/}}
{{- define "postgresql.connectionUrl" -}}
{{- $host := printf "%s.%s.svc.cluster.local" (include "postgresql.fullname" .) .Release.Namespace }}
{{- printf "postgresql://%s:%d/%s" $host (.Values.service.port | default 5432) (.Values.auth.database | default "glassflow") }}
{{- end }}

{{/*
PostgreSQL host (FQDN)
Returns the fully qualified domain name for the PostgreSQL service
*/}}
{{- define "postgresql.host" -}}
{{- printf "%s.%s.svc.cluster.local" (include "postgresql.fullname" .) .Release.Namespace }}
{{- end }}

