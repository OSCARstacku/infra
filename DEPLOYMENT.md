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

# Instalar helm
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

# En infra/kong (sudo su / root / USER):
chmod +x install.sh
./install.sh

# https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/getting-started/

# En infra/pulsar (sudo su / root / USER):
chmod +x install.sh
./install.sh
