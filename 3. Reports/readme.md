# 3. Reports & Visualization

With the policy portion of securing our application complete, we need a way to report that our application is in compliance going forward. There are two main tools for this within Calico Cloud:

## Increasing Log Flush Frequency

By default, flow logs will be flushed from the hosts and stored in Elasticsearch every 300s (5 minutes). During normal operation this default value will be adequate for troubleshooting and auditing. For this workshop, we will reduce our flow log flush interval to 30s to make it easier to see the results of our policies.

*Note - Increasing the frequency of logs sent to Elasticsearch will increase the storage usage.

```bash
kubectl patch felixconfiguration default --type='merge' -p '{"spec":{"flowLogsFlushInterval":"30s"}}'
```

## Visualizations

In Calico Cloud, there are two tools that help us provide visualizations of our cluster and traffic:Service Graph and Flow Visualizations.

### Service Graph

Service Graph is a graph of pod and service communication for all applications within the cluster. Allows for customized views to show relationships between namespaces, services, and deployments

<p align="center">
  <img src="images/service-graph.png" alt="Service Graph" align="center" width="600">
</p>

### Flow Visualization

Calico Cloud logs all network flows including source and destination namespaces, pods, labels, and the policies that evaluate each flow. Logs of all connection attempts (inside and outside the cluster) are automatically generated so you can quickly identify source of connectivity issues.

The Flow Visualizer lets you quickly drill down and pinpoint which policies are allowing and denying traffic between their services.

<p align="center">
  <img src="images/flow-visualizer.png" alt="Flow Visualizations" align="center" width="600">
</p>

### Flow Logs

Calico Cloud includes a fully-integrated deployment of Elasticsearch to collect flow log data that drives key features like the Flow Visualizer, metrics in the dashboard and Policy Board, policy automation and testing features, and security.

Calico Cloud also embeds Kibana to view raw log data for the traffic within your cluster. Kibana provides its own set of powerful filtering capabilities to quickly drilling into log data. For example, use filters to drill into flow log data for specific namespaces and pods. Or view details and metadata for a single flow log entry.

<p align="center">
  <img src="images/flow-logs-kibana.png" alt="Flow Logs Kibana" align="center" width="600">
</p>


## Reset Flow Log Flush Setting

Now that we've seen our traffic in the flow logs, lets reset our flow log flush interval to the default:

```bash
kubectl patch felixconfiguration default --type='merge' -p '{"spec":{"flowLogsFlushInterval":"300s"}}'
```

## Calico Cloud Reports

Using the reporting feature of Calico Cloud we can create a number of reports to satisfy the various PCI DSS and SOC 2 reporting requirements.

Calico Cloud supports the following built-in report types:

- Inventory
- Network Access
- Policy-Audit
- CIS Benchmark

These reports can be customized to report against a certain set of endpoints (for example PCI endpoints).

Compliance reports provide the following high-level information:

- **Protection**
  - Endpoints explicitly protected using ingress or egress policy
  - Endpoints with Envoy enabled
- **Policies and services**
  - Policies and services associated with endpoints
  - Policy audit logs
- **Traffic**
  - Allowed ingress/egress traffic to/from namespaces
  - Allowed ingress/egress traffic to/from the internet


### CIS Benchmark Reports

*CIS Benchmarks are best practices for the secure configuration of a target system.* - [Center for Internet Security](https://www.cisecurity.org/cis-benchmarks/cis-benchmarks-faq)

Being able to assess your Kubernetes clusters against CIS benchmarks is a standard requirement for your organization’s security and compliance posture. Calico Enterprise CIS benchmark compliance reports provide this view into your Kubernetes clusters. 

## Example Reports

### Daily CIS Benchmark

<p align="center">
  <img src="images/cis-benchmark.png" alt="CIS Benchmark Example" align="center" width="600">
</p>

```yaml
kubectl apply -f -<<EOF
apiVersion: projectcalico.org/v3
kind: GlobalReport
metadata:
  name: daily-cis-results
  labels:
    deployment: production
spec:
  reportType: cis-benchmark
  schedule: 0 0 * * *
  cis:
    highThreshold: 100
    medThreshold: 50
    includeUnscoredTests: true
    numFailedTests: 5
    resultsFilters:
      - benchmarkSelection: { kubernetesVersion: "1.20" }
        exclude: ["1.1.4", "1.2.5"]
EOF
```


### Weekly Report - Full Infrastructure Inventory

The following report schedules weekly inventory reports for all endpoints. The jobs that create the reports will run on the infrastructure nodes (e.g. nodetype == ‘infrastructure’).

<p align="center">
  <img src="images/weekly-infrastructure-inventory.png" alt="Full Inventory Example" align="center" width="600">
</p>


```yaml
kubectl apply -f -<<EOF
apiVersion: projectcalico.org/v3
kind: GlobalReport
metadata:
  name: weekly-full-infrastructure-inventory
spec:
  reportType: inventory
  schedule: 0 0 * * 0
  jobNodeSelector:
    nodetype: infrastructure
EOF
```

### Daily Report - Tenant Endpoint Network Access

The following report schedules daily network-access reports all endpoints with the 'tenant=hipstershop' label.

<p align="center">
  <img src="images/tenant-networkaccess.png" alt="Tenant Network-Access Example" align="center" width="600">
</p>


```yaml
kubectl apply -f -<<EOF
apiVersion: projectcalico.org/v3
kind: GlobalReport
metadata:
  name: daily-tenant-hipstershop-networkaccess
spec:
  reportType: network-access
  endpoints:
    selector: tenant == "hipstershop"
  schedule: 0 0 * * *
EOF
```

### Daily Report - PCI Endpoint Inventory

The following report schedules daily inventory reports for all endpoints that have the 'pci=true' label.

<p align="center">
  <img src="images/pci-inventory.png" alt="PCI Inventory Example" align="center" width="600">
</p>

```yaml
kubectl apply -f -<<EOF
apiVersion: projectcalico.org/v3
kind: GlobalReport
metadata:
  name: daily-pci-inventory
spec:
  reportType: inventory
  endpoints:
    selector: pci == "true"
  schedule: 0 0 * * *
EOF
```


### Daily Report - PCI Endpoint Network Access

The following report schedules daily network-access reports for all endpoints that have the 'pci=true' label.

'''bash
kubectl label -n hipstershop pod 
'''

<p align="center">
  <img src="images/pci-network-access.png" alt="PCI Network-Access Example" align="center" width="600">
</p>


```yaml
kubectl apply -f -<<EOF
apiVersion: projectcalico.org/v3
kind: GlobalReport
metadata:
  name: daily-pci-network-access
spec:
  reportType: network-access
  endpoints:
    selector: pci == "true"
  schedule: 0 0 * * *
EOF
```

### Daily Report - PCI Ingress Network Access

The following report schedules daily network-access reports for all endpoints that have the 'infra-pci-ingress=true' label.

To get this report to work, we'll first need to add the 'infra-pci-ingress=true' label to the frontend pods of the Online Boutique. The following command will get the frontend pod name and label it.

```bash
for pod in $(kubectl get pods -n hipstershop -l app=frontend --no-headers -o name); do kubectl label -n hipstershop $pod infra-pci-ingress=true; done
```

<p align="center">
  <img src="images/pci-ingress-networkaccess.png" alt="PCI Ingress Network-Access Example" align="center" width="600">
</p>


```yaml
kubectl apply -f -<<EOF
apiVersion: projectcalico.org/v3
kind: GlobalReport
metadata:
  name: daily-pci-ingress-network-access
spec:
  reportType: network-access
  endpoints:
    selector: infra-pci-ingress == "true"
  schedule: 0 0 * * *
EOF
```

### Hourly Report - Full Inventory

The following report schedules hourly inventory reports for the cluster.

<p align="center">
  <img src="images/hourly-inventory.png" alt="Hourly Inventory Example" align="center" width="600">
</p>


```yaml
kubectl apply -f -<<EOF
apiVersion: projectcalico.org/v3
kind: GlobalReport
metadata:
  name: hourly-inventory-report
spec:
  reportType: inventory
  jobNodeSelector:
    nodetype: infrastructure
  schedule: 0 * * * *
EOF
```

## Known Limitations

**Supported Platforms:**

- Kubernetes, on-premises
- EKS
- AWS using kOps
- RKE

## Reference Documentation

[Calico Cloud Manager UI Tour](https://docs.calicocloud.io/get-started/tutorials/tour)

[Calico Enterprise Documentation for Compliance Reports](https://docs.tigera.io/compliance/overview)  

[Cron Scheduler Tool](https://crontab.guru/)  