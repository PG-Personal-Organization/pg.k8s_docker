kubectl logs POD_NAME

kubectl get pods

kubectl logs -l app=payments --all-containers=true --tail=-1 | grep "c48f4d66-644a-4acd-b05d-063aa0608a69"
