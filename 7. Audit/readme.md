## 7. Audit Logs

With Access, Security Policy and Encryption in place, the next step is to be able to audit the environment for changes and unwanted activity.

The following types of data are logged by Calico Cloud:

* Audit Logs
* DNS Logs
* Flow Logs

This data is stored in the Elasticsearch database for retention, review and export.

## Policy Audit Timeline

Policy Audit logs are also accessible through the Calico Cloud UI directly through the Timeline feature.  To view these logs:

1. Open the Timeline page from the left navigation menu.

<p align="center">
  <img src="images/menu.png" alt="Menu" align="center" width="150">
</p>

2. Either browse through the list of Audit Events or search using the filter at the top of the page.
  * Policy Audit Timeline

    <p align="center">
    <img src="images/timeline.png" alt="Policy Audit Timeline" align="center" width="600">
    </p>  
  * Policy Audit Filter

    <p align="center">
    <img src="images/timeline-filter.png" alt="Policy Audit Filter" align="center" width="600">
    </p>  

3. Policy Audit Events contain the policy effected, the user to make the change and the manifest of the updated policy.

    <p align="center">
    <img src="images/policy-audit.png" alt="Policy Audit Event" align="center" width="600">
    </p>  


## Policy Audit Inside of Policy

Within each Policy, there is a Change Log that allows you to see the audit entries for the specific policy you are currently viewing.

To access this information, 

1. Open a Policy from from the Policies page and scroll down to the Change Log section.

<p align="center">
<img src="images/policy-history.png" alt="Policy History" align="center" width="250">
</p>  

2. Click on the diff button on an Audit Event to expand the details of that event.

<p align="center">
<img src="images/policy-history-2.png" alt="Policy History" align="center" width="600">
</p>  

3. To view the change in detail, click the 'Diff' button in the top right to bring up a side by side comparison of the two versions.

<p align="center">
<img src="images/policy-diff.png" alt="Policy Diff" align="center" width="600">
</p>  


### Kubernetes Host logs (for self-managed clusters)

To enable the collection of Kubernetes audit logs, an audit policy must be enabled on the cluster. The following manifest is provided as an example but this is only supported on self-managed clusters (that were provisioned using kubeadm for example) where the user has access to the control plane directly.

```yaml
kubectl apply -f -<<EOF
apiVersion: audit.k8s.io/v1beta1
kind: Policy
omitStages:
  - RequestReceived
rules:
  - level: RequestResponse
    verbs:
      - create
      - patch
      - update
      - delete
    resources:
      - group: networking.k8s.io
        resources: ["networkpolicies"]
      - group: extensions
        resources: ["networkpolicies"]
      - group: ""
        resources: ["pods", "namespaces", "serviceaccounts", "endpoints"]
EOF
```
> Manifest File: [7.1-kubernetes-audit-logs.yaml](manifests/7.1-kubernetes-audit-logs.yaml)



### A couple of guidelines to follow for Audit Requirements

- Stop using calicoctl
  - Because calicoctl cannot provide audit log data, you can no longer use calicoctl to manage resources (Calico Enterprise and Kubernetes) for compliance reporting. Instead, use kubectl, Manager UI, or the Kubernetes API, to manage policy, tiers, and host endpoints.

- Ensure that all nodes in your Kubernetes clusters must be time-synchronized using NTP or similar (for accurate audit log timestamps)

### Calico Cloud Limitations

>>**Note:** When using a hosted kubernetes service such as AKS, you will not have access to the kubernetes cluster audit logs.

[:arrow_right:8. Alerts](../8.%20Alerts/readme.md)<br>

[:arrow_left:6. Enabling End to End Encryption with WireGuard](../6.%20Encryption/readme.md)

[:leftwards_arrow_with_hook: Back to Main](../README.md)