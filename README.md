# Calico Cloud SOC2 Compliance Workshop

![Calico Cloud](https://docs.tigera.io/assets/images/brand-new-965497f477948b3acbb96626715af849.png)

## Welcome
The intent of this workshop is to provide an introduction to the Calico features that support SOC 2 compliance.

## SOC 2  Trust Services Criteria
SOC 2 is based on five overarching Trust Services Criteria (TSC): security, availability, processing integrity,
confidentiality, and privacy. Specifically, the security criteria are broken down into nine sections called common criteria (CC):

* CC1: Control Environment
* CC2: Communication and Information
* CC3: Risk Assessment
* CC4: Monitoring Activities
* CC5: Control Activities
* CC6: Logical and Physical Access Controls
* CC7: System Operations
* CC8: Change Management
* CC9: Risk Mitigation

## SOC 2 compliance rules mapping to Calico capabilities
Running Kubernetes clusters often presents challenges for CC6 (logical and physical access), CC7 (systems
operations), and CC8 (change management) when trying to comply with SOC 2 standards. 

| Control# | Requirement(s) | Calico control(s) |
| :--------------- | :---------------: | :--------------- |
|CC 6.1, 6.6, 6.7, 6.8| Implement logical access security measures to authorized systems only, implement controls to prevent or detect and act upon introduction of malicious software| <ul><li>Calico can control ingress and egress between microservices and external databases, cloud services, APIs, and other applications.</li><li>Calico can apply least privilege access controls to a cluster, denying all network traffic by default and allowing only those connections that have been authorized.</li><li>Calico can encrypt data in transit for added protection against data tampering</li><li>Calico can organize all SOC 2 endpoints in one or more namespaces.</li><li>Calico configures the namespace for default-deny and whitelists all ingress and egress traffic|
|CC 7.1| Monitor and detect configuration changes and capable of vulnerability management|<ul><li>Calico continuously monitors and logs all workloads for compliance against existing security policies</li><li>Calico alerts on any configuration changes that may impact existing security policies</li><li>Calico scans containers images for vulnerabilities and assigns pass, warn, or fail label to automatically deploy or block the image from deployment|
|CC 7.2, 7.3, 7.4|Monitor systems and components for anomalies and indicators of compromise|<ul><li>Calico anomaly and threat detection capabilities:</li><li>Monitor and analyze threats<li>Automatically quarantine compromised workloads<li>Review network flow logs for statistical and behavioral anomalies</li>|
|CC 8.1|Change Management: Authorize, Track, Approve changes to the system| <ul><li>Calico records all policy changes and provides a change history for audit<li>Calico provides granular control over who is authorized to make changes to policies,endpoints, and namespaces</li>|



## Workshop Objectives

We will be focusing on securing a microservices based application and then providing audit and reporting of the controls that are put in place adhering to SOC2 controls. To accomplish this we will focus on these areas:

- [Section 0. Getting Started](0.%20Getting%20Started/readme.md)
- [Section 1. Deploy AKS](1.%20Deploy%20AKS/readme.md)
- [Section 2. Connect AKS Cluster to Calico Cloud](2.%20Connect%20CC/readme.md)
- [Section 3. Deploy Demo Microservices App](3.%20Deploy%20App/readme.md)
- [Section 4. Apply Security Policies](4.%20Policies/readme.md)
- [Section 5. Reports and Visibility](5.%20Reports/readme.md)
- [Section 6. Enabling End to End Encryption with WireGuard](6.%20Encryption/readme.md)
- [Section 7. Audit Logs](7.%20Audit/readme.md)
- [Section 8. Alerts](8.%20Alerts/readme.md)
- [Section 9. Cleanup](9.%20Cleanup/readme.md)
## SOC2

[SOC2 Description Criteria](https://www.aicpa.org/resources/download/get-description-criteria-for-your-organizations-soc-2-r-report)

## White Papers

[SOC2](https://info.tigera.io/rs/805-GFH-732/images/tigera-assets-whitepaper-soc2.pdf)
