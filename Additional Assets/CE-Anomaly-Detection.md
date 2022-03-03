### Anomaly Detection

To enable anomaly detection:

Download the anomaly detection job manifest:
```bash
curl https://docs.tigera.io/manifests/threatdef/ad-jobs-deployment-managed.yaml -O
```

Now edit the manifest with the cluster name (CLUSTER_NAME) environment variable. This can be found by running:

```bash
kubectl cluster-info dump | grep -i cluster-name
```
In this case our cluster name is 'kubernetes'.
```bash
kubectl cluster-info dump | grep -i cluster-name
                            "--cluster-name=kubernetes",
```

So we'll modify the following line in the 'ad-jobs-deployment-managed.yaml' file:

```yaml
...
116           - name: CLUSTER_NAME
117             value: "kuberenetes"
...
```
And then apply the manfiest:

```bash
kubectl apply -f ad-jobs-deployment-managed.yaml
```

We should then be able to see our anomaly detection pod (ad-jobs-deployment-xxxxx) deployed inside the 'tigera-intrusion-detection' namespace:

```bash
kubectl get pods -n tigera-intrusion-detection
NAME                                              READY   STATUS    RESTARTS   AGE
ad-jobs-deployment-7c8c8564f5-2zbq7               1/1     Running   0          102s
intrusion-detection-controller-54d97f58f7-hzjgz   1/1     Running   14         4d22h
```

We can also check the status of the Anomaly Detection job running inside of the pod using the 'kubectl logs' command. 

```bash
kubectl logs <pod_name> -n tigera-intrusion-detection
```

For the above pod we would use:

```bash
kubectl logs ad-jobs-deployment-7c8c8564f5-2zbq7 -n tigera-intrusion-detection
```
With an output showing the log of
