# 9. Clean up

Delete the demo policies and the apps.

   ```bash
   kubectl delete -f 4.\ Policies/manifests
   kubectl delete -n hipstershop -f https://raw.githubusercontent.com/GoogleCloudPlatform/microservices-demo/main/release/kubernetes-manifests.yaml
   ```

Delete the EKS cluster with ```eksctl```.
   
   ```bash
   eksctl delete cluster -f ./cc-eks-compliance-workshop.yaml
   ```

CloudFormation/eksctl logs will show the teardown of the nodegroup and the cluster, for example:

   ```bash
   2023-03-22 19:16:50 [ℹ]  deleting EKS cluster "cc-eks-compliance-workshop"
   2023-03-22 19:16:51 [ℹ]  will drain 0 unmanaged nodegroup(s) in cluster "cc-eks-compliance-workshop"
   2023-03-22 19:16:51 [ℹ]  starting parallel draining, max in-flight of 1
   2023-03-22 19:16:51 [ℹ]  cordon node "ip-192-168-36-138.ec2.internal"
   2023-03-22 19:16:51 [ℹ]  cordon node "ip-192-168-7-113.ec2.internal"
   2023-03-22 19:17:04 [!]  deleting Pods not managed by ReplicationController, ReplicaSet, Job, DaemonSet or StatefulSet: default/multitool, hipstershop/multitool
   2023-03-22 19:17:05 [!]  deleting Pods not managed by ReplicationController, ReplicaSet, Job, DaemonSet or StatefulSet: default/multitool, hipstershop/multitool
   2023-03-22 19:17:05 [!]  deleting Pods not managed by ReplicationController, ReplicaSet, Job, DaemonSet or StatefulSet: default/multitool, hipstershop/multitool
   2023-03-22 19:17:16 [✔]  drained all nodes: [ip-192-168-36-138.ec2.internal ip-192-168-7-113.ec2.internal]
   2023-03-22 19:17:16 [ℹ]  deleted 0 Fargate profile(s)
   2023-03-22 19:17:17 [✔]  kubeconfig has been updated
   2023-03-22 19:17:17 [ℹ]  cleaning up AWS load balancers created by Kubernetes objects of Kind Service or Ingress
   2023-03-22 19:17:44 [ℹ]
   2 sequential tasks: { delete nodegroup "cc-eks-compliance-workshop-ng-1", delete cluster control plane "cc-eks-compliance-workshop" [async]
   }
   2023-03-22 19:17:44 [ℹ]  will delete stack "eksctl-cc-eks-compliance-workshop-nodegroup-cc-eks-compliance-workshop-ng-1"
   2023-03-22 19:17:44 [ℹ]  waiting for stack "eksctl-cc-eks-compliance-workshop-nodegroup-cc-eks-compliance-workshop-ng-1" to get deleted
   2023-03-22 19:17:44 [ℹ]  waiting for CloudFormation stack "eksctl-cc-eks-compliance-workshop-nodegroup-cc-eks-compliance-workshop-ng-1"
   2023-03-22 19:18:14 [ℹ]  waiting for CloudFormation stack "eksctl-cc-eks-compliance-workshop-nodegroup-cc-eks-compliance-workshop-ng-1"
   2023-03-22 19:18:56 [ℹ]  waiting for CloudFormation stack "eksctl-cc-eks-compliance-workshop-nodegroup-cc-eks-compliance-workshop-ng-1"
   2023-03-22 19:20:30 [ℹ]  waiting for CloudFormation stack "eksctl-cc-eks-compliance-workshop-nodegroup-cc-eks-compliance-workshop-ng-1"
   2023-03-22 19:20:30 [ℹ]  will delete stack "eksctl-cc-eks-compliance-workshop-cluster"
   2023-03-22 19:20:30 [✔]  all cluster resources were deleted
   ```


[:arrow_left:8. Alerts](../8.%20Alerts/readme.md)

[:leftwards_arrow_with_hook: Back to Main](../README.md)


Thank you for your time :pray:<br>