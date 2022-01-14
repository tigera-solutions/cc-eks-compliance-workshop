# Calico Cloud - Compliance Quick Start Guide

This guide will walk you through setting up the various compliance components of Calico Cloud.

It is broken down into 6 main areas:

1. Access
2. Policies
3. Reports
4. Encryption
5. Audits
6. Alerts

---

## 1. Access

### Set Up Users

Calico Cloud supports Google Social Authentication as well as local users and connecting to your own IdP (based on OIDC).

#### Local User Setup

In Kubernetes, cluster roles specify cluster permissions and are bound to users using cluster role bindings. In Calico Cloud we provide the following predefined roles.

**Admin**

- Full access to Calico Cloud Manager
    - Create and modify Calico Cloud resources
    - Superuser access for Kibana, including Elasticsearch user

**Viewer**

- Basic user with access to Calico Cloud Manager and Kibana:
    - List/view Calico Cloud policy, Kubernetes policy, and tier resources
    - List/view logs in Kibana

#### OIDC User Setup

Calico Cloud supports the following IdPs:
- OIDC-based Auth providers (for example Google, Azure AD)

To add an IdP, open a [Support ticket.](https://support.tigera.io/)

#### Reference Documentation

For more details on Users, please see the [Calico Cloud Documentation.](https://docs.calicocloud.io/operations/user-management)

---

## 2. Policies

## Labels

### Label Examples

## Policy Tiers

Why are policy tiers important for Compliance?

### Policy Tier Examples

```yaml
apiVersion: projectcalico.org/v3
kind: Tier
metadata:
  name: security
spec:
  order: 300
---
apiVersion: projectcalico.org/v3
kind: Tier
metadata:
  name: platform
spec:
  order: 200
---
apiVersion: projectcalico.org/v3
kind: Tier
metadata:
  name: application
spec:
  order: 400
```

### Policy Examples

#### PCI 

```yaml
apiVersion: projectcalico.org/v3
kind: GlobalNetworkPolicy
metadata:
  name: default.pci
spec:
  tier: default
  order: 0
  selector: pci == "ok"
  namespaceSelector: ''
  serviceAccountSelector: ''
  ingress:
    - action: Allow
      source:
        selector: pci == "ok"
      destination: {}
    - action: Deny
      source:
        selector: pci != "ok"
      destination: {}
  egress:
    - action: Allow
      source: {}
      destination:
        selector: pci == "ok"
    - action: Deny
      source: {}
      destination:
        selector: pci != "ok"
  doNotTrack: false
  applyOnForward: false
  preDNAT: false
  types:
    - Ingress
    - Egress
```

#### NameSpace Isolation

*Notice the use of the broad scope scd , which matches all pods belonging to those tenants. We could have likewise used namespaceSelector == "tenant1", which can be a better approach if you think about it from a RBAC perspective, where the platform team manages namespace provisioning and labeling, while developers manage deployments to their authorised namespaces and pod labels.*

*What this is actually doing is delegating (passing) controls for tenant1 to the application tier after implementing high-level security controls at the security tier level. High level security controls are typically implemented through enterprise security guidelines and compliance requirements for intra-cluster and external communication. At the application tier level, granular microsegmentation would be implmentated by developers to secure microservices.*

*It is important here to understand the policy processing behavior of Calico Enterprise:*

*The default action for selected endpoint within a policy tier is Deny
The default action for non-selected endpoint within a policy tier is Pass
Pass action happens at the end of a policy tier
This means that for any selected endpoints in a policy tier, communication that is not explicitly permitted or passed is denied. This means that in the very simple policy we have implemented, we have effectively isolated tenant1 and tenant2. Communication for tenant1 for example outside the scope of its own tenant is denied since we're selecting tenant1 and only passing communication with its own tenant. Notice the default deny at the security tier effectively enforces organisation controls including multi-tenancy. Whatever is not passed or allowed is denied.*

*Take a moment and reflect on how it would have entailed to implement the same in a legacy infrastructure. The possibilities are simply unlimited!*

```yaml
apiVersion: projectcalico.org/v3
kind: GlobalNetworkPolicy
metadata:
  name: security.pass-tenant1
spec:
  tier: security
  order: 101
  selector: tenant == "tenant1"
  types:
  - Ingress
  ingress:
  - action: Allow
    protocol: TCP
    destination:
      selector: ingress == "true"
      ports:
      - 80
  - action: Pass
    destination:
      selector: tenant == "tenant1"
---
apiVersion: projectcalico.org/v3
kind: GlobalNetworkPolicy
metadata:
  name: security.pass-tenant2
spec:
  tier: security
  order: 102
  selector: tenant == "tenant2"
  types:
  - Ingress
  ingress:
  - action: Pass
    destination:
      selector: tenant == "tenant2"
---
apiVersion: projectcalico.org/v3
kind: GlobalNetworkPolicy
metadata:
  name: security.default-deny-security-tier
spec:
  tier: security
  order: 999999
  selector: all()
  types:
  - Ingress
  ingress:
  - action: Deny
```

---

## 3. Reports

### Built in Report Types

- Inventory
- Network Access
- Policy-Audit

### Example Reports

#### Weekly Report - All Endpoints

The following report schedules weekly inventory reports for all endpoints. The jobs that create the reports will run on the infrastructure nodes (e.g. nodetype == ‘infrastructure’).

```yaml
apiVersion: projectcalico.org/v3
kind: GlobalReport
metadata:
  name: weekly-full-inventory
spec:
  reportType: inventory
  schedule: 0 0 * * 0
  jobNodeSelector:
    nodetype: infrastructure
```

#### Daily Report - Endpoints in Selected Namespace

The following report schedules daily network-access reports for the accounts department with endpoints specified using a namespace selector.

```yaml
apiVersion: projectcalico.org/v3
kind: GlobalReport
metadata:
  name: daily-accounts-networkaccess
spec:
  reportType: network-access
  endpoints:
    namespaces:
      selector: department == 'accounts'
  schedule: 0 0 * * *
```

### Additional Report Resources

[Calico Enterprise Documentation for Compliance Reports](https://docs.tigera.io/compliance/overview)  
[Cron Scheduler Tool](https://crontab.guru/)  


---

## 4. Encryption

Calico Supports Encryption in transit



#### Encryption in Transit Documentation

[Calico Enterprise Documentation for Encryption in Transit](https://docs.tigera.io/compliance/encrypt-cluster-pod-traffic)