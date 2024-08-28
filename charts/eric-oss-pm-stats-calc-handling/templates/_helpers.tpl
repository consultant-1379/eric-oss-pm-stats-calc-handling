{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "eric-oss-pm-stats-calc-handling.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "eric-oss-pm-stats-calc-handling.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create version
*/}}
{{- define "eric-oss-pm-stats-calc-handling.version" -}}
{{- printf "%s" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "eric-oss-pm-stats-calc-handling.global-security-tls-enabled" -}}
{{- if  .Values.global -}}
  {{- if  .Values.global.security -}}
    {{- if  .Values.global.security.tls -}}
      {{- .Values.global.security.tls.enabled | toString -}}
    {{- else -}}
      {{- "false" -}}
    {{- end -}}
  {{- else -}}
    {{- "false" -}}
  {{- end -}}
{{- else -}}
  {{- "false" -}}
{{- end -}}
{{- end -}}

{{- define "eric-oss-pm-stats-calc-handling.service-mesh-enabled" }}
  {{- $globalMeshEnabled := "false" -}}
  {{- if .Values.global -}}
    {{- if .Values.global.serviceMesh -}}
        {{- $globalMeshEnabled = .Values.global.serviceMesh.enabled -}}
    {{- end -}}
  {{- end -}}
  {{- $globalMeshEnabled -}}
{{- end -}}

{{/*
This helper captures the issuer reference name of the out-mesh service CNOM, that wants to communicate with PMQ.
*/}}
{{- define "eric-oss-pm-stats-calc-handling.osmService-cnom-issuerRef" }}
{{- if eq (include "eric-oss-pm-stats-calc-handling.pmq-osm2ism-enabled" .) "true" }}
  {{- $outMeshServiceCnomIssuerRef := "" -}}
  {{- if index .Values "eric-oss-pm-stats-query-service" "osm2ism" "outMeshServices" -}}
    {{- if index .Values "eric-oss-pm-stats-query-service" "osm2ism" "outMeshServices" "cnom" -}}
      {{- if eq (include "eric-oss-pm-stats-calc-handling.pmq-osmService-cnom-enabled" .) "true" }}
        {{- if eq (include "eric-oss-pm-stats-calc-handling.osmService-cnom-issuerRef-enabled" .) "true" }}
            {{- $outMeshServiceCnomIssuerRef = (index .Values "eric-oss-pm-stats-query-service" "osm2ism" "outMeshServices" "cnom" "intermediateCA" "name") | toString -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $outMeshServiceCnomIssuerRef -}}
{{- end -}}
{{- end -}}

{{/*
This helper captures the issuer reference name of the out-mesh service CSAC, that wants to communicate with PMSC.
*/}}
{{- define "eric-oss-pm-stats-calc-handling.osmService-csac-issuerRef" }}
{{- if eq (include "eric-oss-pm-stats-calc-handling.pmsc-osm2ism-enabled" .) "true" }}
  {{- $outMeshServiceCsacIssuerRef := "" -}}
  {{- if index .Values "eric-oss-pm-stats-calculator" "osm2ism" "outMeshServices" -}}
    {{- if index .Values "eric-oss-pm-stats-calculator" "osm2ism" "outMeshServices" "csac" -}}
      {{- if eq (include "eric-oss-pm-stats-calc-handling.pmsc-osmService-csac-enabled" .) "true" }}
        {{- if eq (include "eric-oss-pm-stats-calc-handling.osmService-csac-issuerRef-enabled" .) "true" }}
            {{- $outMeshServiceCsacIssuerRef = (index .Values "eric-oss-pm-stats-calculator" "osm2ism" "outMeshServices" "csac" "intermediateCA" "name") | toString -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $outMeshServiceCsacIssuerRef -}}
{{- end -}}
{{- end -}}

{{/*
This helper checks the issuer reference for the out-mesh service CNOM for PMQ.
*/}}
{{- define "eric-oss-pm-stats-calc-handling.osmService-cnom-issuerRef-enabled" }}
{{- if eq (include "eric-oss-pm-stats-calc-handling.pmq-osm2ism-enabled" .) "true" }}
  {{- $osmserviceCnomIssuerRefEnabled := "false" -}}
  {{- if index .Values "eric-oss-pm-stats-query-service" "osm2ism" "outMeshServices" -}}
    {{- if index .Values "eric-oss-pm-stats-query-service" "osm2ism" "outMeshServices" "cnom" -}}
      {{- if eq (include "eric-oss-pm-stats-calc-handling.pmq-osmService-cnom-enabled" .) "true" }}
        {{- if index .Values "eric-oss-pm-stats-query-service" "osm2ism" "outMeshServices" "cnom" "intermediateCA" "enabled" -}}
            {{- $osmserviceCnomIssuerRefEnabled = (index .Values "eric-oss-pm-stats-query-service" "osm2ism" "outMeshServices" "cnom" "intermediateCA" "enabled") | toString -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $osmserviceCnomIssuerRefEnabled -}}
{{- end -}}
{{- end -}}

{{/*
This helper checks the issuer reference for the out-mesh service CSAC for PMSC.
*/}}
{{- define "eric-oss-pm-stats-calc-handling.osmService-csac-issuerRef-enabled" }}
{{- if eq (include "eric-oss-pm-stats-calc-handling.pmsc-osm2ism-enabled" .) "true" }}
  {{- $osmserviceCsacIssuerRefEnabled := "false" -}}
  {{- if index .Values "eric-oss-pm-stats-calculator" "osm2ism" "outMeshServices" -}}
    {{- if index .Values "eric-oss-pm-stats-calculator" "osm2ism" "outMeshServices" "csac" -}}
      {{- if eq (include "eric-oss-pm-stats-calc-handling.pmsc-osmService-csac-enabled" .) "true" }}
        {{- if index .Values "eric-oss-pm-stats-calculator" "osm2ism" "outMeshServices" "csac" "intermediateCA" "enabled" -}}
            {{- $osmserviceCsacIssuerRefEnabled = (index .Values "eric-oss-pm-stats-calculator" "osm2ism" "outMeshServices" "csac" "intermediateCA" "enabled") | toString -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $osmserviceCsacIssuerRefEnabled -}}
{{- end -}}
{{- end -}}

{{/*
This helper captures the service name of out-mesh service CNOM, which wants to communicate with PMQ.
*/}}
{{- define "eric-oss-pm-stats-calc-handling.pmq-osmService-cnom-name" }}
{{- if eq (include "eric-oss-pm-stats-calc-handling.pmq-osm2ism-enabled" .) "true" }}
  {{- $outMeshCnomServiceName := "" -}}
  {{- if index .Values "eric-oss-pm-stats-query-service" "osm2ism" "outMeshServices" -}}
    {{- if eq (include "eric-oss-pm-stats-calc-handling.pmq-osmService-cnom-enabled" .) "true" }}
        {{- $outMeshCnomServiceName = (index .Values "eric-oss-pm-stats-query-service" "osm2ism" "outMeshServices" "cnom" "name") | trunc 30 | toString -}}
    {{- end -}}
  {{- end -}}
  {{- $outMeshCnomServiceName -}}
{{- end -}}
{{- end -}}
{{/*
This helper captures the service name of out-mesh service CSAC, which wants to communicate with PMSC.
*/}}
{{- define "eric-oss-pm-stats-calc-handling.pmsc-osmService-csac-name" }}
{{- if eq (include "eric-oss-pm-stats-calc-handling.pmsc-osm2ism-enabled" .) "true" }}
  {{- $outMeshCsacServiceName := "" -}}
  {{- if index .Values "eric-oss-pm-stats-calculator" "osm2ism" "outMeshServices" -}}
    {{- if eq (include "eric-oss-pm-stats-calc-handling.pmsc-osmService-csac-enabled" .) "true" }}
        {{- $outMeshCsacServiceName = (index .Values "eric-oss-pm-stats-calculator" "osm2ism" "outMeshServices" "csac" "name") | trunc 30 | toString -}}
    {{- end -}}
  {{- end -}}
  {{- $outMeshCsacServiceName -}}
{{- end -}}
{{- end -}}

{{/*
This helper checks osm2ism is enabled for the out-mesh service CNOM for PMQ.
*/}}
{{- define "eric-oss-pm-stats-calc-handling.pmq-osmService-cnom-enabled" }}
{{- if eq (include "eric-oss-pm-stats-calc-handling.service-mesh-enabled" .) "true" }}
  {{- $serviceCnomEnabled := "false" -}}
  {{- if index .Values "eric-oss-pm-stats-query-service" "osm2ism" "outMeshServices" -}}
    {{- if index .Values "eric-oss-pm-stats-query-service" "osm2ism" "outMeshServices" "cnom" "enabled" -}}
      {{- $serviceCnomEnabled = (index .Values "eric-oss-pm-stats-query-service" "osm2ism" "outMeshServices" "cnom" "enabled") | toString -}}
    {{- end -}}
  {{- end -}}
  {{- $serviceCnomEnabled -}}
{{- end -}}
{{- end -}}

{{/*
This helper checks osm2ism is enabled for the out-mesh service CSAC for PMSC.
*/}}
{{- define "eric-oss-pm-stats-calc-handling.pmsc-osmService-csac-enabled" }}
{{- if eq (include "eric-oss-pm-stats-calc-handling.service-mesh-enabled" .) "true" }}
  {{- $serviceCsacEnabled := "false" -}}
  {{- if index .Values "eric-oss-pm-stats-calculator" "osm2ism" "outMeshServices" -}}
    {{- if index .Values "eric-oss-pm-stats-calculator" "osm2ism" "outMeshServices" "csac" "enabled" -}}
      {{- $serviceCsacEnabled = (index .Values "eric-oss-pm-stats-calculator" "osm2ism" "outMeshServices" "csac" "enabled") | toString -}}
    {{- end -}}
  {{- end -}}
  {{- $serviceCsacEnabled -}}
{{- end -}}
{{- end -}}

{{/*
This helper checks whether osm2ism is enabled for the service PMQ.
*/}}
{{- define "eric-oss-pm-stats-calc-handling.pmq-osm2ism-enabled" }}
  {{- $osm2ismEnabled := "false" -}}
  {{- if index .Values "eric-oss-pm-stats-query-service" -}}
    {{- if index .Values "eric-oss-pm-stats-query-service" "osm2ism" -}}
      {{- if index .Values "eric-oss-pm-stats-query-service" "osm2ism" "enabled" -}}
        {{- $osm2ismEnabled = (index .Values "eric-oss-pm-stats-query-service" "osm2ism" "enabled") | toString -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $osm2ismEnabled -}}
{{- end -}}

{{/*
This helper checks whether osm2ism is enabled for the service PMSC.
*/}}
{{- define "eric-oss-pm-stats-calc-handling.pmsc-osm2ism-enabled" }}
  {{- $osm2ismEnabled := "false" -}}
  {{- if index .Values "eric-oss-pm-stats-calculator" -}}
    {{- if index .Values "eric-oss-pm-stats-calculator" "osm2ism" -}}
      {{- if index .Values "eric-oss-pm-stats-calculator" "osm2ism" "enabled" -}}
        {{- $osm2ismEnabled = (index .Values "eric-oss-pm-stats-calculator" "osm2ism" "enabled") | toString -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $osm2ismEnabled -}}
{{- end -}}

{{/*
Create Ericsson product app.kubernetes.io info
*/}}
{{- define "eric-oss-pm-stats-calc-handling.kubernetes-io-info" -}}
app.kubernetes.io/name: {{ .Chart.Name | quote }}
app.kubernetes.io/version: {{ .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Create Ericsson Product Info
*/}}
{{- define "eric-oss-pm-stats-calc-handling.product-info" -}}
ericsson.com/product-name: {{ (fromYaml (.Files.Get "eric-product-info.yaml")).productName | quote }}
ericsson.com/product-number: {{ (fromYaml (.Files.Get "eric-product-info.yaml")).productNumber | quote }}
ericsson.com/product-revision: {{regexReplaceAll "(.*)[+|-].*" .Chart.Version "${1}" | quote }}
{{- end }}

{{/*
Create image pull secrets for keycloak client
*/}}
{{- define "eric-oss-pm-stats-calc-handling.pullSecrets" -}}
{{- if .Values.imageCredentials -}}
  {{- if .Values.imageCredentials.pullSecret -}}
    {{- print .Values.imageCredentials.pullSecret -}}
  {{- end -}}
  {{- else if .Values.global.pullSecret -}}
    {{- print .Values.global.pullSecret -}}
  {{- end -}}
{{- end -}}


{{/*
Create a user defined annotation (DR-D1121-065, DR-D1121-060)
*/}}
{{ define "eric-oss-pm-stats-calc-handling.config-annotations" }}
  {{- $global := (.Values.global).annotations -}}
  {{- $service := .Values.annotations -}}
  {{- include "eric-oss-pm-stats-calc-handling.mergeAnnotations" (dict "location" .Template.Name "sources" (list $global $service)) }}
{{- end }}

{{/*
Merged annotations for Default, which includes productInfo and config
*/}}
{{- define "eric-oss-pm-stats-calc-handling.helm-annotations" -}}
  {{- $productInfo := include "eric-oss-pm-stats-calc-handling.product-info" . | fromYaml -}}
  {{- $config := include "eric-oss-pm-stats-calc-handling.config-annotations" . | fromYaml -}}
  {{- include "eric-oss-pm-stats-calc-handling.mergeAnnotations" (dict "location" .Template.Name "sources" (list $productInfo $config)) | trim }}
{{- end -}}

{{/*
Create a user defined label (DR-D1121-068, DR-D1121-060)
*/}}
{{ define "eric-oss-pm-stats-calc-handling.config-labels" }}
  {{- $global := (.Values.global).labels -}}
  {{- $service := .Values.labels -}}
  {{- include "eric-oss-pm-stats-calc-handling.mergeLabels" (dict "location" .Template.Name "sources" (list $global $service)) }}
{{- end }}

{{/*
Merged labels for Default, which includes Standard and Config
*/}}
{{- define "eric-oss-pm-stats-calc-handling.labels" -}}
  {{- $standard := include "eric-oss-pm-stats-calc-handling.standard-labels" . | fromYaml -}}
  {{- $config := include "eric-oss-pm-stats-calc-handling.config-labels" . | fromYaml -}}
  {{- include "eric-oss-pm-stats-calc-handling.mergeLabels" (dict "location" .Template.Name "sources" (list $standard $config)) | trim }}
{{- end -}}

{{/*
DR-D1121-102 main image pull policy
*/}}

{{- define "eric-oss-pm-stats-calc-handling.registryImagePullPolicy" -}}
    {{- $globalRegistryPullPolicy := "IfNotPresent" -}}
    {{- if .Values.global -}}
        {{- if .Values.global.registry -}}
            {{- if .Values.global.registry.imagePullPolicy -}}
                {{- $globalRegistryPullPolicy = .Values.global.registry.imagePullPolicy -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}
    {{- print $globalRegistryPullPolicy -}}
{{- end -}}

{{/*

Define a imagePath template for all images in eric-product-info.yaml (DR-D1121-067)

*/}}

{{- define "eric-oss-pm-stats-calc-handling.imagePath" }}
    {{- $imageId := index . "imageId" -}}
    {{- $values := index . "values" -}}
    {{- $files := index . "files" -}}
    {{- $productInfo := fromYaml ($files.Get "eric-product-info.yaml") -}}
    {{- $registryUrl := index $productInfo "images" $imageId "registry" -}}
    {{- $repoPath := index $productInfo "images" $imageId "repoPath" -}}
    {{- $name := index $productInfo "images" $imageId "name" -}}
    {{- $tag :=  index $productInfo "images" $imageId "tag" -}}
    {{- if $values.global -}}
        {{- if $values.global.registry -}}
            {{- $registryUrl = default $registryUrl $values.global.registry.url -}}
        {{- end -}}
    {{- end -}}
    {{- if $values.imageCredentials -}}
        {{- if $values.imageCredentials.registry -}}
            {{- $registryUrl = default $registryUrl $values.imageCredentials.registry.url -}}
        {{- end -}}
        {{- if not (kindIs "invalid" $values.imageCredentials.repoPath) -}}
            {{- $repoPath = $values.imageCredentials.repoPath -}}
        {{- end -}}
        {{- $image := index $values.imageCredentials $imageId -}}
        {{- if $image -}}
            {{- if $image.registry -}}
                {{- $registryUrl = default $registryUrl $image.registry.url -}}
            {{- end -}}
            {{- if not (kindIs "invalid" $image.repoPath) -}}
                {{- $repoPath = $image.repoPath -}}
            {{- end -}}
            {{- if not (kindIs "invalid" $image.tag) -}}
                {{- $tag = $image.tag -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}
    {{- if $repoPath -}}
        {{- $repoPath = printf "%s/" $repoPath -}}
    {{- end -}}
    {{- printf "%s/%s%s:%s" $registryUrl $repoPath $name $tag -}}
{{- end -}}

{{/*
Create a merged set of nodeSelectors from global and service level.
*/}}
{{- define "eric-oss-pm-stats-calc-handling.nodeSelector" -}}
{{- $globalValue := (dict) -}}
{{- if .Values.global -}}
    {{- if .Values.global.nodeSelector -}}
      {{- $globalValue = .Values.global.nodeSelector -}}
    {{- end -}}
{{- end -}}
{{- if .Values.nodeSelector -}}
  {{- range $key, $localValue := .Values.nodeSelector -}}
    {{- if hasKey $globalValue $key -}}
         {{- $Value := index $globalValue $key -}}
         {{- if ne $Value $localValue -}}
           {{- printf "nodeSelector \"%s\" is specified in both global (%s: %s) and service level (%s: %s) with differing values which is not allowed." $key $key $globalValue $key $localValue | fail -}}
         {{- end -}}
     {{- end -}}
    {{- end -}}
nodeSelector: {{- toYaml (merge $globalValue .Values.nodeSelector) | trim | nindent 8 -}}
{{- else -}}
  {{- if not ( empty $globalValue ) -}}
nodeSelector: {{- toYaml $globalValue | trim | nindent 8 -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
The name of the cluster role used during openshift deployments.
This helper is provided to allow use of the new global.security.privilegedPolicyClusterRoleName if set, otherwise
use the previous naming convention of <release_name>-allowed-use-privileged-policy for backwards compatibility.
*/}}
{{- define "eric-oss-pm-stats-calc-handling.privileged.cluster.role.name" -}}
  {{- if ((.Values.global).security).privilegedPolicyClusterRoleName -}}
    {{ .Values.global.security.privilegedPolicyClusterRoleName }}
  {{- else -}}
    {{ template "eric-oss-pm-stats-calc-handling.release.name" . }}-allowed-use-privileged-policy
  {{- end -}}
{{- end -}}

{{/*
Define PMH App Service Account name
*/}}
{{- define "eric-oss-pm-stats-calc-handling.serviceaccount" -}}
  {{- $name := include "eric-oss-pm-stats-calc-handling.name" . -}}
  {{- printf "%s-%s" $name "sa" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Define tolerations to comply to DR-D1120-060 and DR-D1120-061
*/}}
{{- define "eric-oss-pm-stats-calc-handling.tolerations" -}}
  {{- $tolerations := list -}}
  {{- if .Values.tolerations -}}
      {{- if ne (len .Values.tolerations) 0 -}}
        {{- range $t := .Values.tolerations -}}
          {{- $tolerations = append $tolerations $t -}}
        {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- if .Values.global -}}
    {{- if .Values.global.tolerations -}}
      {{- if ne (len .Values.global.tolerations) 0 -}}
        {{- range $t := .Values.global.tolerations -}}
          {{- $tolerations = append $tolerations $t -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{ toYaml $tolerations }}
{{- end -}}
