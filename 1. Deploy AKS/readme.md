# 1. Deploy an Azure AKS Cluster

1. Define the environment variables to be used by the resources definition.

   > **NOTE**: In the following sections we'll be generating and setting some environment variables. If you're terminal session restarts you may need to reset these variables. You can use that via the following command:
   >
   > source ~/workshopvars.env

   ```bash
   export RESOURCE_GROUP=rg-compliance-workshop
   export CLUSTERNAME=aks-compliance-workshop
   export LOCATION=canadacentral
   # Persist for later sessions in case of disconnection.
   echo export RESOURCE_GROUP=$RESOURCE_GROUP >> ~/workshopvars.env
   echo export CLUSTERNAME=$CLUSTERNAME >> ~/workshopvars.env
   echo export LOCATION=$LOCATION >> ~/workshopvars.env
   ```

2. If not created, create the Resource Group in the desired Region.
   
   ```bash
   az group create \
     --name $RESOURCE_GROUP \
     --location $LOCATION
   ```
   
3. Create the AKS cluster without a network policy engine.
   
   ```bash
   az aks create \
     --resource-group $RESOURCE_GROUP \
     --name $CLUSTERNAME \
     --kubernetes-version 1.23 \
     --location $LOCATION \
     --node-count 2 \
     --node-vm-size Standard_B2ms \
     --max-pods 100 \
     --generate-ssh-keys \
     --network-plugin azure 
   ```
   Time to grab a :coffee: while this runs. You should see `\ Running ..` while the cluster is being setup. 

4. Verify your cluster status. The `ProvisioningState` should be `Succeeded`

   ```bash
   az aks list -g $RESOURCE_GROUP -o table
   ```
   Or
   ```bash
   watch az aks list -g $RESOURCE_GROUP -o table
   ```
   
   You may get an output like the following

   <pre>
   Name                     Location       ResourceGroup           KubernetesVersion    CurrentKubernetesVersion    ProvisioningState    Fqdn
   -----------------------  -------------  ----------------------  -------------------  --------------------------  -------------------  -----------------------------------------------------------------------
   aks-compliance-workshop  canadacentral  rg-compliance-workshop  1.23                 1.23.15                     Succeeded            aks-compli-rg-compliance-wo-03cfb8-cb3730b2.hcp.canadacentral.azmk8s.io
   </pre>

5. Get the credentials to connect to the cluster.
   
   ```bash
   az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTERNAME
   ```

6. Verify you have API access to your new AKS cluster

   ```bash
   kubectl get nodes
   ```

   The output will ne something similar to the this:

   <pre>
   NAME                                STATUS   ROLES   AGE     VERSION
   aks-nodepool1-17553008-vmss000000   Ready    agent   3m52s   v1.23.15
   aks-nodepool1-17553008-vmss000001   Ready    agent   3m46s   v1.23.15
   </pre>

   To see more details about your cluster:

   ```bash
    kubectl cluster-info
   ```

   The output will be something similar to the this:
   <pre>
   Kubernetes control plane is running at https://aks-compli-rg-compliance-wo-03cfb8-cb3730b2.hcp.canadacentral.azmk8s.io:443
   CoreDNS is running at https://aks-compli-rg-compliance-wo-03cfb8-cb3730b2.hcp.canadacentral.azmk8s.io:443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
   Metrics-server is running at https://aks-compli-rg-compliance-wo-03cfb8-cb3730b2.hcp.canadacentral.azmk8s.io:443/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy
    
   To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
   </pre>

   You should now have a Kubernetes cluster running with 2 nodes. You do not see the master servers for the cluster because these are managed by Microsoft. The Control Plane services which manage the Kubernetes cluster such as scheduling, API access, configuration data store and object controllers are all provided as services to the nodes.

7. Verify the settings required for Calico Cloud.
   
   ```bash
   az aks show --resource-group $RESOURCE_GROUP --name $CLUSTERNAME --query 'networkProfile'
   ```

   You should see "networkPlugin": "azure" and "networkPolicy": null (networkPolicy may not show if it is null).

8. Verify the transparent mode by running the following command in one node

   ```bash
   VMSSGROUP=$(az vmss list --output table | grep -i $RESOURCE_GROUP | awk -F ' ' '{print $2}')
   VMSSNAME=$(az vmss list --output table | grep -i $RESOURCE_GROUP | awk -F ' ' '{print $1}')
   az vmss run-command invoke -g $VMSSGROUP -n $VMSSNAME --scripts "cat /etc/cni/net.d/*" --command-id RunShellScript --instance-id 0 --query 'value[0].message' --output table
   ```
   
   > output should contain "mode": "transparent"


## Install calicoctl tool for use in later labs
Follow the instructions for your platform and method of choice [HERE](https://docs.tigera.io/calico/3.25/operations/calicoctl/install)<br>

>>>**Note:** Installing the binary is the easiest way for the purpose of this lab

---

[:arrow_right:2. Connect cluster to Calico Cloud](../2.%20Connect%20CC/readme.md) <br>

[:arrow_left:0. Getting Started](../0.%20Getting%20Started/readme.md)

[:leftwards_arrow_with_hook: Back to Main](../README.md)  
