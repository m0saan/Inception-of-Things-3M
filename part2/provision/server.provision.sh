SERVER_IP="$1"
INSTALL_K3S_EXEC="--node-ip ${SERVER_IP} --write-kubeconfig-mode=644 --log /vagrant/logs/server.logs"
curl -fsL https://get.k3s.io | INSTALL_K3S_EXEC="$INSTALL_K3S_EXEC" sh -
echo $INSTALL_K3S_EXEC

echo "Waiting for K3s to be fully initialized..."
while [ ! -f /etc/rancher/k3s/k3s.yaml ]; do
  echo "Waiting for /etc/rancher/k3s/k3s.yaml to be available..."
  sleep 5
done

# Wait for the K3s API server to be ready
echo "Waiting for K3s API server to be ready..."
until kubectl get nodes &>/dev/null; do
  echo "Waiting for K3s API server..."
  sleep 5
done

kubectl apply -f /vagrant/provision/app1/app1.deployment.yaml
kubectl apply -f /vagrant/provision/app1/app1.service.yaml

kubectl apply -f /vagrant/provision/app2/app2.deployment.yaml
kubectl apply -f /vagrant/provision/app2/app2.service.yaml

kubectl apply -f /vagrant/provision/app3/app3.deployment.yaml
kubectl apply -f /vagrant/provision/app3/app3.service.yaml

kubectl create configmap nginx3-welcome --from-file=/vagrant/provision/app3/index.html
kubectl create configmap nginx-welcome --from-file=/vagrant/provision/app1/index.html
kubectl create configmap nginx2-welcome --from-file=/vagrant/provision/app2/index.html

kubectl apply -f /vagrant/provision/ingress.yaml

echo "${SERVER_IP} app1.example.com" >> /etc/hosts
echo "${SERVER_IP} app2.example.com" >> /etc/hosts
echo "${SERVER_IP} app3.example.com" >> /etc/hosts