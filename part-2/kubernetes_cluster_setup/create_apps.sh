sudo kubectl apply -f /vagrant/k3s_apps/deployments/app1-deployment.yaml > /dev/null
sudo kubectl wait deployment app-one --for condition=Available=True --timeout=-1s
echo "App1 is ready!"


sudo kubectl apply -f /vagrant/k3s_apps/deployments/app2-deployment.yaml > /dev/null
sudo kubectl wait deployment app-two --for condition=Available=True --timeout=-1s
echo "App2 is ready!"

sudo kubectl apply -f /vagrant/k3s_apps/deployments/app3-deployment.yaml > /dev/null
sudo kubectl wait deployment app-three --for condition=Available=True --timeout=-1s
echo "App3 is ready!"


sudo kubectl apply -f /vagrant/k3s_apps/ingress/ingress.yaml > /dev/null
while [ -z $external_ip ]; do echo "Waiting ingress...";
external_ip=$(sudo kubectl get ing iot-ingress --output="jsonpath={.status.loadBalancer.ingress[0].ip}");
[ -z "$external_ip" ] && sleep 10;
done;
echo "Ingress is ready with the external_ip: ${external_ip}"
