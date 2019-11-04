# Digital Ocean Kubernetes Helper

This image is used to start rolling updates on digital ocean within a continuous deployment pipeline. The image requires the environment variables `DIGITALOCEAN_ACCESS_TOKEN` for doctl authentication. 


```bash
cat <<EOF > start-rolling-update.sh 
doctl kubernetes cluster kubeconfig save $CLUSTER
kubectl rollout restart deployment.apps/frontend 
kubectl rollout restart deployment.apps/backend
EOF

docker run --rm -e CLUSTER=my-cluster -e DIGITALOCEAN_ACCESS_TOKEN -v $(pwd)/start-rolling-update.sh:/start-rolling-update.sh:ro --entrypoint=/bin/sh deeneri0/digital-ocean-kubernetes-helper -- /start-rolling-update.sh
```