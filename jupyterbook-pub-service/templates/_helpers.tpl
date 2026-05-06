{{- /*
    Render the YAML volume config for storage
*/}}
{{- define "jupyterbook-pub-service.storageVolume" -}}
{{- if .Values.volumeClaim.enabled -}}
persistentVolumeClaim:
  claimName: {{ include "jupyterbook-pub-service.app.fullname" . | quote }} 
{{- else -}}
{{ .Values.volume | toYaml  }}
{{- end }}
{{- end }}

{{- /* ServiceAccount name */}}
{{- define "jupyterbook-pub-service.app.serviceaccount.fullname" -}}
    {{- if .Values.serviceAccount.create }}
        {{- .Values.serviceAccount.name | default (include "jupyterbook-pub-service.app.fullname" .) }}
    {{- else }}
        {{- .Values.serviceAccount.name }}
    {{- end }}
{{- end }}
