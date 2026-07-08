# Aplicar infraestructura en Kubernetes (Raíz principal ejemplo mss-sdata):
sudo kubectl apply -f infra/namespace.yaml
sudo kubectl apply -f infra/mongodb/

# Verificar infraestructura en Kubernetes:
sudo kubectl get pods -n sdata
sudo kubectl get all -n sdata
sudo kubectl get pvc -n sdata
sudo kubectl get deployments -n sdata
sudo kubectl get services -n sdata

# Eliminar infraestructura en Kubernetes:
sudo kubectl delete -f infra/namespace.yaml
sudo kubectl delete -f infra/mongodb/