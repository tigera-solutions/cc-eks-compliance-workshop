# 1. Deploy an AWS EKS Cluster

We will be using the ```eksctl``` CLI tool with a config file to deploy the EKS cluster with AWS VPC CNI. 
```eksctl``` needs to installed whether you are using a local environment or AWS CloudShell.

## Pre-requisites

- Install ```eksctl``` and setup as per the [official instructions](https://github.com/weaveworks/eksctl#installation) for your environment of choice or AWS CloudShell (Linux)

  The following instructions are for installing it into AWS CloudShell (which is a Linux environment)
  
  ```bash
  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
  sudo mv /tmp/eksctl /usr/local/bin
  ```

## EKS Cluster Installation

1. Create a config YAML file to be used by ```eksctl```

   ```bash
   cat <<EOF > ./cc-eks-compliance-workshop.yaml
   apiVersion: eksctl.io/v1alpha5
   kind: ClusterConfig
   availabilityZones:
      - us-east-1c
      - us-east-1d

   metadata:
      name: cc-eks-compliance-workshop
      region: us-east-1
      
   managedNodeGroups:
      - name: cc-eks-compliance-workshop-ng-1
      instanceType: c5.large
      minSize: 2
      maxSize: 3
      desiredCapacity: 2
      volumeSize: 40
      labels: {role: worker}
      tags:
         nodegroup-role: worker
   EOF
   ```

2. Create the EKS cluster with AWS VPC CNI using eksctl.

   ```bash
   eksctl create cluster -f cc-eks-compliance-workshop.yaml
   ```

   Time to grab a :coffee: while this runs. You will see logs from AWS CloudFormation for the stacks while the cluster is being created, like so:

   ```bash
   2023-03-20 17:44:23 [✔]  all EKS cluster resources for "cc-eks-compliance-workshop" have been created
   2023-03-20 17:44:24 [ℹ]  nodegroup "cc-eks-compliance-workshop-ng-1" has 2 node(s)
   2023-03-20 17:44:24 [ℹ]  node "ip-192-168-18-242.ec2.internal" is ready
   2023-03-20 17:44:24 [ℹ]  node "ip-192-168-48-126.ec2.internal" is ready
   2023-03-20 17:44:24 [ℹ]  waiting for at least 2 node(s) to become ready in "cc-eks-compliance-workshop-ng-1"
   2023-03-20 17:44:24 [ℹ]  nodegroup "cc-eks-compliance-workshop-ng-1" has 2 node(s)
   2023-03-20 17:44:24 [ℹ]  node "ip-192-168-18-242.ec2.internal" is ready
   2023-03-20 17:44:24 [ℹ]  node "ip-192-168-48-126.ec2.internal" is ready
   2023-03-20 17:44:24 [ℹ]  kubectl command should work with "/Users/user/.kube/config", try 'kubectl get nodes'
   2023-03-20 17:44:24 [✔]  EKS cluster "cc-eks-compliance-workshop" in "us-east-1" region is ready
   ```

3. Verify your cluster status, it should show as ```ACTIVE```

   ```bash
   eksctl get cluster --region=us-east-1 --name=cc-eks-compliance-workshop
   ```

   You may get an output like the following

   ```bash
   NAME                         VERSION STATUS  CREATED                 VPC                   SUBNETS                                                                                                 SECURITYGROUPS          PROVIDER
   cc-eks-compliance-workshop      1.24    ACTIVE  2023-03-20T21:28:49Z    vpc-078c6e3207e83fdf6   subnet-02bfed82dd9ff1fb0,subnet-0368fbf1efa78d4a4,subnet-0433d63cf31349a0d,subnet-05aa06443f70f4655     sg-0e04e814a00712d99    EKS
   ```


4. Verify you have API access to your new AKS cluster

   ```bash
   kubectl get nodes
   ```

   The output will ne something similar to the this:

   ```bash
   NAME                             STATUS   ROLES    AGE   VERSION
   ip-192-168-18-242.ec2.internal   Ready    <none>   97m   v1.24.10-eks-48e63af
   ip-192-168-48-126.ec2.internal   Ready    <none>   97m   v1.24.10-eks-48e63af
   ```

   To see more details about your cluster:

   ```bash
    kubectl cluster-info
   ```

   The output will be something similar to the this:

   ```bash
   Kubernetes control plane is running at https://<redacted>.us-east-1.eks.amazonaws.com
   CoreDNS is running at https://<redacted>.us-east-1.eks.amazonaws.com/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

   To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
   ```

   You should now have a Kubernetes cluster running with 2 nodes. You do not see the master servers for the cluster because these are managed by AWS. The Control Plane services which manage the Kubernetes cluster such as scheduling, API access, configuration data store and object controllers are all provided as services to the nodes.

## Install calicoctl tool for use in later labs

Follow the instructions for your platform and method of choice [HERE](https://docs.tigera.io/calico/3.24/operations/calicoctl/install#install-calicoctl-as-a-binary-on-a-single-host)<br>

>>>**Note:** Installing the binary is the easiest way for the purpose of this lab

   ```bash
   curl -L https://github.com/projectcalico/calico/releases/latest/download/calicoctl-linux-amd64 -o calicoctl
   sudo mv calicoctl /usr/local/bin
   sudo chmod +x /usr/local/bin/calicoctl
   ```

---

[:arrow_right:2. Connect cluster to Calico Cloud](../2.%20Connect%20CC/readme.md) <br>

[:arrow_left:0. Getting Started](../0.%20Getting%20Started/readme.md)

[:leftwards_arrow_with_hook: Back to Main](../README.md)  
