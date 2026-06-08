{{/*
공통 라벨. 사용: {{ include "docux.labels" (dict "root" . "component" "api") | nindent 4 }}
서비스명·셀렉터는 컴포넌트명으로 고정한다(릴리스 prefix 미사용 — config의 DNS 단축명과 일치).
*/}}
{{- define "docux.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .root.Chart.Name .root.Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/part-of: docux
app.kubernetes.io/managed-by: {{ .root.Release.Service }}
app.kubernetes.io/instance: {{ .root.Release.Name }}
app.kubernetes.io/name: {{ .component }}
app.kubernetes.io/component: {{ .component }}
{{- end -}}

{{/*
셀렉터 라벨(불변 — Deployment selector/Service selector 공용).
사용: {{ include "docux.selectorLabels" (dict "root" . "component" "api") | nindent 6 }}
*/}}
{{- define "docux.selectorLabels" -}}
app.kubernetes.io/name: {{ .component }}
app.kubernetes.io/instance: {{ .root.Release.Name }}
{{- end -}}

{{/*
이미지 문자열. 사용: {{ include "docux.image" .Values.api.image }}
repository는 전체 경로(레지스트리 포함). public 이미지(postgres 등)도 그대로 동작.
*/}}
{{- define "docux.image" -}}
{{- printf "%s:%s" .repository (.tag | toString) -}}
{{- end -}}
