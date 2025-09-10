--- Ingress setup ---

kubectl create namespace ingress-nginx

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

----

---- Node exporter ---

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring --create-namespace

sleep 3

kubectl delete daemonset monitoring-prometheus-node-exporter -n monitoring
kubectl delete service monitoring-prometheus-node-exporter -n monitoring

----