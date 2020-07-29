sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce 
sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli
sudo rm -rf /var/lib/docker /etc/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock
sudo su <<EOF
mkdir -p /etc/systemd/system/docker.service.d
EOF
sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
# Restart Docker
su -c ~/main3.sh root
systemctl daemon-reload
systemctl restart docker
EOF
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubectl kubeadm
sudo apt-mark hold kubelet kubeadm kubectl
