SERVER_IP="$1"
INSTALL_K3S_EXEC="--node-ip ${SERVER_IP} --write-kubeconfig-mode=644 --log /vagrant/logs/server.logs"
curl -fsL https://get.k3s.io | INSTALL_K3S_EXEC="$INSTALL_K3S_EXEC" sh -
echo $INSTALL_K3S_EXEC
while [ ! -f /etc/rancher/k3s/k3s.yaml ]; do
  echo "Waiting for /etc/rancher/k3s/k3s.yaml to be available..."
  sleep 5
done
sudo cp /etc/rancher/k3s/k3s.yaml /vagrant/provision/config
sudo cp /var/lib/rancher/k3s/server/token /vagrant/provision/token
