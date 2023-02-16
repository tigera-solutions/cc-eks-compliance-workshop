# 9. Clean up

Delete the demo policies and the apps.

   ```bash
   kubectl delete -f 4.\ Policies/manifests
   kubectl delete -n hipstershop -f https://raw.githubusercontent.com/GoogleCloudPlatform/microservices-demo/main/release/kubernetes-manifests.yaml
   ```

Delete the AKS cluster.
   
   ```bash
   az aks delete \
     --resource-group $RESOURCE_GROUP \
     --name $CLUSTERNAME
   ```

Delete the resource group.
   
   ```bash
   az group delete \
     --name $RESOURCE_GROUP
   ```

Delete environment variables backup file.

   ```bash
   rm ~/workshopvars.env
   ```

[:arrow_left:8. Alerts](../8.%20Alerts/readme.md)

[:leftwards_arrow_with_hook: Back to Main](../README.md)


Thank you for your time :pray:<br>