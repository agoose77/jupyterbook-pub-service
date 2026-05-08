{{- /*
  Core labels
*/}}
{{- define "jupyterbook-pub-service.coreLabels" -}}
app.kubernetes.io/name: {{ .Values.nameOverride | default .Chart.Name | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- /*
  App labels
*/}}
{{- define "jupyterbook-pub-service.appLabels" -}}
{{ include "jupyterbook-pub-service.coreLabels" .  }}
app.kubernetes.io/component: app
{{- end }}

{{- /*
  Common labels
*/}}
{{- define "jupyterbook-pub-service.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{ include "jupyterbook-pub-service.coreLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

