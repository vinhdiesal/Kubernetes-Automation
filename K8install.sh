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
su -c ~/main.sh root
sudo cp /etc/kubernetes/admin.conf $HOME/
sudo chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf
kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.3/aio/deploy/recommended.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.3/aio/deploy/recommended.yaml
kubectl create serviceaccount dashboard-admin-sa
kubectl create clusterrolebinding dashboard-admin-sa --clusterrole=cluster-admin --serviceaccount=default:dashboard-admin-sa
kubectl create -f - <<EOF
kind: PersistentVolume
apiVersion: v1
metadata:
  name: pv-volume1
spec:
  storageClassName:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/pv2"
EOF
kubectl create -f - <<EOF
kind: PersistentVolume
apiVersion: v1
metadata:
  name: pv-volume2
spec:
  storageClassName:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/pv2"
EOF
kubectl create -f - <<EOF
kind: PersistentVolume
apiVersion: v1
metadata:
  name: pv-volume3
spec:
  storageClassName:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/pv3"
EOF
kubectl create -f - <<EOF
kind: PersistentVolume
apiVersion: v1
metadata:
  name: pv-volume4
spec:
  storageClassName:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/pv4"
EOF
helm repo add larribas https://larribas.me/helm-charts
helm repo update
kubectl create namespace mlflow
kubectl create namespace airflow
kubectl create namespace jenkins
helm install --namespace mlflow mlflow larribas/mlflow
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install --namespace airflow airflow bitnami/airflow --version 6.3.6
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install --namespace jenkins jenkins bitnami/jenkins
