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

./infra/kong/install.sh
