# ###############################################################
#                           Kubernetes
# ###############################################################

# IMPORTANTE
sudo kubectl logs -f deployment/sdata-ms-base -n sdata

# Eliminar namespace preso
sudo kubectl get namespace sdata -o json | tr -d "\n" | sed "s/\"finalizers\": \[[^]]*\]/\"finalizers\": []/" | sudo kubectl replace --raw /api/v1/namespaces/sdata/finalize -f -

# Configurar kubectl para usuario actual (si se está utilizando sudo):
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config
export KUBECONFIG=$HOME/.kube/config
# source ~/.bashrc

# Verificar infraestructura en Kubernetes:
sudo kubectl get all
sudo kubectl get all -n sdata

# Eliminar todo:
sudo kubectl delete all --all 
sudo kubectl delete all --all -n default ó sdata (-n es namespace)

sudo kubectl delete deployment --all
sudo kubectl delete service --all
sudo kubectl delete pvc --all
sudo kubectl delete configmap --all
sudo kubectl delete secret --all

# Crear namespace
sudo kubectl create namespace sdata

# Borrar namespace
sudo kubectl delete namespace sdata

# Verificar namespace
sudo kubectl get namespaces
sudo kubectl get ns

# Configurar namespace actual como predeterminado
sudo kubectl config set-context --current --namespace=sdata

# Comprobar namespace actual
sudo kubectl config view --minify | grep namespace

# Ver logs del pod anterior (en caso de error)
sudo kubectl logs deployment/sdata-ms-base -n sdata --previous
sudo kubectl describe pod sdata-ms-base-774f796f9-t7xqx -n sdata

# ###############################################################

# Listar pods
sudo kubectl get pods

# Listar servicios
sudo kubectl get services

# Listar configmaps
sudo kubectl get configmaps

# Listar secrets
sudo kubectl get secrets

# Listar deployments
sudo kubectl get deployments

# Listar replicasets
sudo kubectl get replicasets

# ###############################################################

# Aplicar infraestructura en Kubernetes (Raíz principal ejemplo mss-sdata):
sudo kubectl apply -f infra/namespace.yaml
sudo kubectl apply -f infra/mongodb/
sudo kubectl apply -f infra/dragonfly/
# sudo kubectl apply -f infra/pulsar/
# sudo kubectl apply -k infra/pulsar/zookeeper/
# sudo kubectl apply -k infra/pulsar/bookkeeper/

# Para borrar zookeeper

# sudo kubectl delete deployment zookeeper-deployment -n sdata
# sudo kubectl delete deployment bookkeeper-deployment -n sdata
# sudo kubectl delete service zookeeper-service -n sdata
# sudo kubectl delete service bookkeeper-service -n sdata
# sudo kubectl delete pvc bookkeeper-pvc -n sdata

# sudo kubectl apply -f infra/kong/

# Revisar todo por ejemplo de pulsar
sudo kubectl get all --all-namespaces | grep pulsar

# Verificar infraestructura en Kubernetes:
sudo kubectl get pods -n sdata -w
sudo kubectl get all -n sdata
sudo kubectl get pvc -n sdata
sudo kubectl get deployments -n sdata
sudo kubectl get services -n sdata

# Eliminar infraestructura en Kubernetes:
sudo kubectl delete -f infra/namespace.yaml
sudo kubectl delete -f infra/mongodb/

# Listar imágenes de K3s:
sudo k3s crictl images

# ###############################################################
#                           Helm
# ###############################################################

helm version

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash


cd infra/pulsar

helm repo add apache https://pulsar.apache.org/charts
helm repo update
chmod +x install.sh
sudo ./install.sh

# Para borrar kong o pulsar:
helm uninstall pulsar -n sdata

# Para borrar ingressclass kong en caso de tenerlo en default
sudo kubectl delete ingressclass kong

# Apache Pulsar
Infraestructura de mensajería de SDATA.

Componentes desplegados:

- ZooKeeper
- BookKeeper
- Broker
- Proxy

Namespace:

sdata

Instalación:

./install.sh

Desinstalación:

./uninstall.sh


