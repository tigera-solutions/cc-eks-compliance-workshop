# SOC2 Compliance Workshop

![Calico Cloud](https://docs.tigera.io/assets/images/brand-new-965497f477948b3acbb96626715af849.png)

## Welcome
The intent of this workshop is to provide an introduction to the Calico features that support SOC 2 compliance.

## SOC 2  Trust Services Criteria
SOC 2 is based on five overarching Trust Services Criteria (TSC): security, availability, processing integrity,
confidentiality, and privacy. Specifically, the security criteria are broken down into nine sections called common
criteria (CC):
<ul><li>CC1: Control Environment</li>
<li>CC2: Communication and Information</li>
<li>CC3: Risk Assessment</li>
<li>CC4: Monitoring Activities</li>
<li>CC5: Control Activities</li>
<li>CC6: Logical and Physical Access Controls</li>
<li>CC7: System Operations</li>
<li>CC8: Change Management</li>
<li>CC9: Risk Mitigation</li>

## SOC 2 compliance rules mapping to Calico capabilities
Running Kubernetes clusters often presents challenges for CC6 (logical and physical access), CC7 (systems
operations), and CC8 (change management) when trying to comply with SOC 2 standards. 

| Control# | Requirement(s) | Calico control(s) |
| --------------- | --------------- | --------------- |
|CC 6.1, 6.6, 6.7, 6.8| Implement logical access security measures to authorized systems only, implement controls to prevent or detect and act upon introduction of malicious software| <ul><li>Calico can control ingress and egress between microservices and external databases, cloud services, APIs, and other applications.</li><li>Calico can apply least privilege access controls to a cluster, denying all network traffic by default and allowing only those connections that have been authorized.</li><li>Calico can encrypt data in transit for added protection against data tampering</li><li>Calico can organize all SOC 2 endpoints in one or more namespaces.</li><li>Calico configures the namespace for default-deny and whitelists all ingress and egress traffic



## Objectives

During this workshop, we will be focusing on securing a microservices based application and then providing audit and reporting of the controls that are put in place adhering to SOC2 controls. To accomplish this we will focus on these areas:

- [Section 0. Lab Setup](0.%20Lab%20Setup/readme.md)
- [Section 1. Calico Cloud Access Controls](1.%20Access/readme.md)
- [Section 2. Security Policies](2.%20Policies/readme.md)
- [Section 3. Reporting and Visibility](3.%20Reports/readme.md)
- [Section 4. End-to-end Encryption](4.%20Encryption/readme.md)
- [Section 5. Audit Logs](5.%20Audit/readme.md)
- [Section 6. Alerts](6.%20Alerts/readme.md)
- [Section 7. Cleanup](7.%20Cleanup/readme.md)
- [Additional Assets](Additional%20Assets/readme.md)

## PCI DSS

[SOC2 Description Criteria](https://www.aicpa.org/resources/download/get-description-criteria-for-your-organizations-soc-2-r-report)

## White Papers

[SOC2](https://info.tigera.io/rs/805-GFH-732/images/tigera-assets-whitepaper-soc2.pdf)
