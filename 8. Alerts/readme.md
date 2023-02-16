# Alerts

Alerts allow you to be notified when key events happen in your Kubernetes environment. Calico supports alerting on the following datasets:

* Audit Logs
* DNS Logs
* Flow Logs

> Alerts can be configured either through the CLI or through the Calico Cloud UI.

## Alert Examples

Here is an example of an alert that can be configured through manifests:

**Detect SSH traffic in the 'hipstershop' namespace:**

**Use-case**: Since the only allowed traffic should be between the microservices and SSH traffic to any of the pods is anamolous behaviour, an alert can be configured if attempted traffic is detected on the standard TCP port 22

```yaml
kubectl apply -f -<<EOF
apiVersion: projectcalico.org/v3
kind: GlobalAlert
metadata:
  name: network.ssh-to-hipstershop
spec:
  description: "ssh flows to hipstershop namespace"
  summary: "[flows] ssh flow in hipstershop namespace detected from ${source_namespace}/${source_name_aggr}"
  severity: 100
  period: 10m
  lookback: 10m
  dataSet: flows
  query: proto='tcp' AND action='allow' AND dest_port='22' AND (source_namespace='hipstershop' OR dest_namespace='hipstershop') AND reporter=src
  aggregateBy: [source_namespace, source_name_aggr]
  field: num_flows
  metric: sum
  condition: gt
  threshold: 0
EOF
```


### Reference Documentation

[Calico Global Alerts](https://docs.tigera.io/visibility/alerts#create-a-global-alert)
[Calico Global Alert Reference](https://docs.tigera.io/reference/resources/globalalert)

[:arrow_right:9. Cleanup](../9.%20Cleanup/readme.md)<br>

[:arrow_left:7. Audit Logs](../7.%20Audit/readme.md)

[:leftwards_arrow_with_hook: Back to Main](../README.md)