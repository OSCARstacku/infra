# ###############################################################
#                          DEPLOYMENT
# ###############################################################

# Crear namespace
# sudo kubectl create namespace sdata

# Configurar namespace actual como predeterminado
# sudo kubectl config set-context --current --namespace=sdata

# Verificar namespace
# sudo kubectl config view --minify | grep namespace

# Aplicar infraestructura en Kubernetes (Raíz principal ejemplo mss-sdata):
kubectl apply -f infra/namespace.yaml
kubectl config set-context --current --namespace=sdata
kubectl config view --minify | grep namespace

kubectl apply -f infra/mongodb/
kubectl apply -f infra/dragonfly/

# En infra/metallb (sudo su / root / USER):
hostname -I
# Verifica rango de IPs
for i in {240..250}; do
  ping -c1 -W1 192.168.0.$i >/dev/null \
    && echo "192.168.0.$i OCUPADA" \
    || echo "192.168.0.$i LIBRE"
done

# Instalar helm y metallb
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

chmod +x install.sh
./install.sh

kubectl apply -f ipaddresspool.yaml
kubectl apply -f l2advertisement.yaml

kubectl get ipaddresspool -n metallb-system
kubectl get l2advertisement -n metallb-system

kubectl get pods
kubectl get pvc
kubectl get statefulsets

# Levantar Dockerfile de kong
cd ~/Documentos/mss-sdata
docker build \
-t kong-grpc:3.9.3 \
-f infra/kong/Dockerfile .
docker images | grep sdata-kong

# Cargar el runtime
docker save kong-grpc:3.9.3 -o kong-grpc.tar

# Importar la imagen en k3s
sudo k3s ctr images import kong-grpc.tar
sudo k3s ctr images list | grep kong-grpc

# Verificar
docker run --rm -it sdata-kong:3.9.3 sh

# En infra/kong (sudo su / root / USER) SOLO PARA INSTALACIÓN INICIAL:
chmod +x install.sh
./install.sh

# Para redeploy
./deploy.sh
kubectl rollout restart deployment kong -n sdata

# Revisar protos en KONG:
kubectl logs -n sdata deployment/kong -c proxy | grep grpc
kubectl exec -it -n sdata deploy/kong -c proxy -- \
ls /etc/kong/protos/base/v1

# Otra forma
# kubectl exec -it -n sdata deployment/kong -c proxy -- sh
# ls /etc/kong
# ls /etc/kong/protos

# Debe aparecer:
base.proto

kubectl exec -it -n sdata deploy/kong -c proxy -- \
ls /etc/kong/protos/google/api

# Debe aparecer: 
annotations.proto
http.proto
...

# Modificar el archivo gprc.lua
mkdir -p infra/kong

kubectl cp \
sdata/$(kubectl get pod -n sdata -l app=kong -o jsonpath='{.items[0].metadata.name}'):/usr/local/share/lua/5.1/kong/tools/grpc.lua \
infra/kong/grpc.lua \
-c proxy

# https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/getting-started/

# En infra/pulsar (sudo su / root / USER):
chmod +x install.sh
./install.sh
