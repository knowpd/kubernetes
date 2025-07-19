README
======


### Create a cluster (from the control node)
* Ref:
  - <https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/>
  - <https://docs.tigera.io/calico/latest/getting-started/kubernetes/self-managed-onprem/onpremises>
  - <https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/>

* Steps:
  1. Install prerequisites:
     - Run: `./install-containerd.sh` and `./install-kubeadm.sh`

  1. Create a cluster
     ```bash
     sudo kubeadm init --pod-network-cidr=192.168.0.0/16
     ```

     - NOTE: The output is like the following:
       ```
       To start using your cluster, you need to run the following as a regular user:
                                       
         mkdir -p $HOME/.kube                                           
         sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
         sudo chown $(id -u):$(id -g) $HOME/.kube/config                                                                                 
       
       Alternatively, if you are the root user, you can run:
       
         export KUBECONFIG=/etc/kubernetes/admin.conf
                                                                                                                                         
       You should now deploy a pod network to the cluster.                                                                               
       Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
         https://kubernetes.io/docs/concepts/cluster-administration/addons/
                                                                                                                                         
       Then you can join any number of worker nodes by running the following on each as root:
                                       
       kubeadm join 10.0.1.4:6443 --token n9mth8.rf6rso6tpebk2k1i \
               --discovery-token-ca-cert-hash sha256:731846cdafb7a9ff4bbf36738b3a8e1017c28225c6d51a8e58b6b1902c127b2d 
       ```

  2. Install Calico using Manifest   (NOTE: Another method is to use Operator)
     ```bash
     kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.30.2/manifests/calico.yaml
     ``` 


### Add worker node (from each work node)
* Steps:
  0. Install prerequisites:
     - Run: `./install-containerd.sh` and `./install-kubeadm.sh`

  1. Join this work node to the conrol node. Use the output of `kubeadm init`.
     - Example:
       ```
       kubeadm join 10.0.1.4:6443 --token n9mth8.rf6rso6tpebk2k1i \
               --discovery-token-ca-cert-hash sha256:731846cdafb7a9ff4bbf36738b3a8e1017c28225c6d51a8e58b6b1902c127b2d 
       ```


### Troubleshoot:
* Problem: A relgular user continues to use /etc/kubernetes/admin.conf, not $HOME/.kube/config.
  - To fix, run `unset KUBECONFIG`

