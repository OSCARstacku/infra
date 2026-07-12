# ###############################################################
#                          DEPLOYMENT
# ###############################################################

# Crear namespace
sudo kubectl create namespace sdata

# Configurar namespace actual como predeterminado
sudo kubectl config set-context --current --namespace=sdata

# Aplicar infraestructura en Kubernetes (Raíz principal ejemplo mss-sdata):
sudo kubectl apply -f infra/namespace.yaml
sudo kubectl apply -f infra/mongodb/
sudo kubectl apply -f infra/dragonfly/

# En infra/kong (sudo su):
chmod +x install.sh
sudo ./install.sh

# https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/getting-started/

# En infra/pulsar (sudo su):
chmod +x install.sh
sudo ./install.sh
