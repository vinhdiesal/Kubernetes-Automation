# Kubernetes-Automation
Created a script which automates the installations and setups of Kubernetes on baremetal from scratch on the master node.
This installation will take care of installing docker and kubernetes dependencies in addition to the following:
```
Configure Calico
Configure Kuberetes Dashboard 
Create Persistent Volumes (qty. 4 Volumes at 10Gb each)
Install the following helm charts: 
Airflow
MLFlow
Jenkins
```
To use this, download the repo and put the `main.sh` in your `home directory`, for example /home/user
Put the `K8install.sh` in any directory, for example `/home/user/Documents`

It should open up the Kubernetes Dashboard. You can get the token by simple calling out `kubectl describe secrets`
