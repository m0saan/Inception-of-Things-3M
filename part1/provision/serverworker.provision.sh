WORKER_IP="$1"
SERVER_IP="$2"
TOKEN_FILE="/vagrant/provision/token"
INSTALL_K3S_EXEC="agent --server https://${SERVER_IP}:6443 --token-file $TOKEN_FILE --node-ip ${WORKER_IP} --log /vagrant/logs/agent.logs"
mkdir $HOME/.kube
cp /vagrant/provision/config $HOME/.kube/config
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="$INSTALL_K3S_EXEC" sh -
