sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
swapoff -a
kubeadm reset
kubeadm init
sudo cp /etc/kubernetes/admin.conf $HOME/
sudo chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf
