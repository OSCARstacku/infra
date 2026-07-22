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
sudo kubectl apply -f infra/namespace.yaml
sudo kubectl config set-context --current --namespace=sdata
sudo kubectl config view --minify | grep namespace

sudo kubectl apply -f infra/mongodb/
sudo kubectl apply -f infra/dragonfly/

# En infra/metallb (sudo su):
chmod +x install.sh
sudo ./install.sh

sudo kubectl apply -f ipaddresspool.yaml
sudo kubectl apply -f l2advertisement.yaml

sudo kubectl get ipaddresspool -n metallb-system
sudo kubectl get l2advertisement -n metallb-system

sudo kubectl get pods
sudo kubectl get pvc
sudo kubectl get statefulsets

# En infra/kong (sudo su):
chmod +x install.sh
./install.sh

# https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/getting-started/

# En infra/pulsar (sudo su):
chmod +x install.sh
./install.sh
