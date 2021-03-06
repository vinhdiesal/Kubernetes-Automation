# Kubernetes-Automation
Based on the latest documentation of Kubernetes I created a script which automates the installations and setups of Kubernetes on baremetal from scratch on the master node. This file has been developed and tested only for `Ubuntu 20.04`. To automate the worker nodes, use the `K8-worker.sh` script.

This installation will take care of installing docker and kubernetes dependencies in addition to the following:

- Configures Calico Network
- Configures Kuberetes Dashboard 
- Create Persistent Volumes (qty. 4 Volumes at 10Gb each)

Download the repository and put the `main.sh` and `main3.sh` in your `home directory`, for example `/home/user`.
Put the `K8install.sh` in any directory, for example `/home/user/Documents`

Note: Before you start I recommend that you set your su password.

Simple navigate into the directory of `k8install.sh` and execute the command: 
```
./k8install.sh
```
Interact with the y/n and password prompts.

After Kubernetes installation is completed, I recommend you editing your bashrc file: 

```
nano ~/.bashrc
```
Insert the following 
```
export KUBECONFIG=$HOME/admin.conf4
```
Then save: 
```
source ~/.bashrc
```
Access the Kubernetes Dashboard like you normally would. To get the log-in token, simply type in the following: 
```
kubectl describe secrets
```
Enjoy!
