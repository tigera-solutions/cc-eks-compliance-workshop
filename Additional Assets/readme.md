# Additional Tools and Assets

In addition to tools and features already explored, Calico Cloud offers the following tools to aid in security and compliance:

## Intrusion Detection

### Anomaly Detection

To configure anomaly detection:

https://docs.tigera.io/threat/anomaly-detection/customizing

### Honeypods

To deploy Honepods:

https://docs.tigera.io/threat/honeypod/honeypods#deploy-honeypods-in-clusters

### Deep Packet Inspection

```
apiVersion: projectcalico.org/v3
kind: DeepPacketInspection
metadata:
  name: sample-dpi
  namespace: default
spec:
  selector: app == "frontend"
```
