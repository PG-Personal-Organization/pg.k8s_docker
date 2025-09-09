kubectl logs context-auth-85cfb64cb4-cd7kl

kubectl exec -n kube-system -it fluent-bit-54mp4 -- ls /var/lib/docker/containers | head


kubectl logs  fluent-bit-cmxrs  -n kube-system

fluent-bit-54mp4

kubectl get pods

kubectl logs -l app=payments --all-containers=true --tail=-1 | grep "c48f4d66-644a-4acd-b05d-063aa0608a69"

kubectl exec -n kube-system -it fluent-bit-hw9kk -- curl -s http://elasticsearch:9200

kubectl exec -n kube-system -it fluent-bit-fswrt -- ls -lh /var/log/containers | head


http://elastic.local/_cat/indices?v

ls -lh /var/lib/docker/containers/03023f2da39cad0bc729f10faddedd7a5cd0455f60295dc1502cb8bb4764ae6d | head
