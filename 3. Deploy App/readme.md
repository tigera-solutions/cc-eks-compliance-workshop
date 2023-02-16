# 3. Deploy Demo Microservices App

**Create a Namespace for the application**

First, let's create a namespace called 'hipstershop' for the application:

```bash
kubectl create namespace hipstershop
```

**Deploy the application**

Next we will deploy the Online Boutique (Hipstershop) application to the namespace. This will install the application from the Google repository.

```bash
kubectl apply -n hipstershop -f https://raw.githubusercontent.com/GoogleCloudPlatform/microservices-demo/main/release/kubernetes-manifests.yaml
```


**Verify Pods are Running**

After deploying the application, wait for all pods to come online in the namespace, this will take a couple of minutes.
```bash
kubectl get pods -n hipstershop
```

The output should look similar to below.
```bash
NAME                                     READY   STATUS    RESTARTS   AGE
adservice-776f7f9bb-z7pjc                1/1     Running   0          50s
cartservice-55cd86d896-5mxh4             1/1     Running   0          51s
checkoutservice-5944bf5f96-dqrf5         1/1     Running   0          52s
currencyservice-5478cb46cd-ss22v         1/1     Running   0          51s
emailservice-97556899b-ntr69             1/1     Running   0          52s
frontend-746879fd55-t9hnz                1/1     Running   0          52s
loadgenerator-6cdf76b6d4-wvg64           1/1     Running   0          51s
paymentservice-6b74ff9f78-pknsj          1/1     Running   0          52s
productcatalogservice-86ddd945bb-9zmh8   1/1     Running   0          51s
recommendationservice-955dccff4-mp6j6    1/1     Running   0          52s
redis-cart-5b569cd47-cm8tt               1/1     Running   0          50s
shippingservice-7784dcb6c8-p6pms         1/1     Running   0          51s
```


**Deploy Network-MultiTool Pod in the default namespace**

The Network-MultiTool pod will be used in two namespaces to test the created network policies.

First, deploy the MultiTool into the default namespace:

```bash
kubectl run multitool --image=wbitt/network-multitool
```

**Deploy a second copy of Network-Multitool to the hipstershop namespace**

Next, deploy a copy of the Mutlitool into the hipstershop namespace:

```bash
kubectl run multitool -n hipstershop --image=wbitt/network-multitool
```

Verify that both pods are up and running:

```bash
kubectl get pods -A | grep multitool
```

Both pods should be Running:

```bash
default                      multitool                                        1/1     Running            0              12s
hipstershop                  multitool                                        1/1     Running            0              31m
```


**Test Connectivity to frontend-external service**

First, get the private ClusterIP address of the frontend-external service:
```bash
kubectl get svc -n hipstershop frontend-external
```
```bash
NAME                TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)        AGE
frontend-external   LoadBalancer   10.0.166.118   20.175.137.173   80:32360/TCP   5m26s
```

Next, connect to the shell inside of the Network-Multitool pod in default namespace using kubectl exec:
```bash
kubectl exec multitool --stdin --tty -- /bin/bash
```

Now we'll use curl to verify we can reach the web frontend of the application (your **ClusterIP** address might be different in your cluster, replace it accordingly):
```bash
bash-5.1# curl -I 10.49.14.192 
HTTP/1.1 200 OK
Set-Cookie: shop_session-id=90f6ea0d-9b4f-4bea-9abd-5f347509b6a7; Max-Age=172800
Date: Wed, 15 Feb 2023 22:58:54 GMT
Content-Type: text/html; charset=utf-8
```
Exit the shell by typing **exit**

[:arrow_right:4. Apply Security Policies](../4.%20Policies/readme.md)<br>

[:arrow_left:2. Connect cluster to Calico Cloud](../2.%20Connect%20CC/readme.md)

[:leftwards_arrow_with_hook: Back to Main](../README.md)  

