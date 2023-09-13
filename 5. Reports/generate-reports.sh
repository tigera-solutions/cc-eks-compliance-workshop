#!/usr/bin/env bash

# get Calico version
CALICO_VERSION=v3.17.1
# CALICO_VERSION=$(kubectl get clusterinformation default -ojsonpath='{.spec.cnxVersion}')

# report names
INVENTORY_REPORT_NAME='daily-soc2-inventory'
NETWORK_ACCESS_REPORT_NAME='daily-soc2-network-access'
POLICY_AUDIT_REPORT_NAME='daily-hipstershop-policy-audit'
CIS_BENCHMARK_NAME='daily-cis-benchmark'

# for managed clusters you must set ELASTIC_INDEX_SUFFIX var to cluster name in the reporter pod template YAML
ELASTIC_INDEX_SUFFIX=$(kubectl get deployment -n tigera-intrusion-detection intrusion-detection-controller -ojson | jq -r '.spec.template.spec.containers[0].env[] | select(.name == "CLUSTER_NAME").value')

# on MacOS
START_TIME=$(date -v -1H -u +'%Y-%m-%dT%H:%M:%SZ')
END_TIME=$(date -u +'%Y-%m-%dT%H:%M:%SZ')

sed -e "s?<CALICO_VERSION>?$CALICO_VERSION?g" \
  -e "s?<ELASTIC_INDEX_SUFFIX>?$ELASTIC_INDEX_SUFFIX?g" \
  -e "s?<INVENTORY_REPORT_NAME>?$INVENTORY_REPORT_NAME?g" \
  -e "s?<NETWORK_ACCESS_REPORT_NAME>?$NETWORK_ACCESS_REPORT_NAME?g" \
  -e "s?<POLICY_AUDIT_REPORT_NAME>?$POLICY_AUDIT_REPORT_NAME?g" \
  -e "s?<CIS_BENCHMARK_NAME>?$CIS_BENCHMARK_NAME?g" \
  -e "s?<TIGERA_COMPLIANCE_REPORT_START_TIME>?$START_TIME?g" \
  -e "s?<TIGERA_COMPLIANCE_REPORT_END_TIME>?$END_TIME?g" \
  5.\ Reports/manifests/compliance-reporter-pod.yaml | kubectl apply -f -