# Aplicar infraestructura en Kubernetes (Raíz principal ejemplo mss-sdata):
kubectl apply -f infra/namespace.yaml
kubectl apply -f infra/mongodb/

# Verificar infraestructura en Kubernetes:
kubectl get all -n sdata
kubectl get pvc -n sdata
kubectl get deployments -n sdata
kubectl get services -n sdata

# Eliminar infraestructura en Kubernetes:
kubectl delete -f infra/namespace.yaml
kubectl delete -f infra/mongodb/