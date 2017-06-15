#!/bin/bash

IP=$1
MINION_NO=${IP:(-1)}

function configure-kubelet()
{
  sed -i '/KUBELET_ADDRESS/c\KUBELET_ADDRESS="--address=0.0.0.0"' /etc/kubernetes/kubelet
  sed -i '/KUBELET_PORT/c\KUBELET_PORT="--port=10250"' /etc/kubernetes/kubelet
  sed -i "/KUBELET_HOSTNAME/c\KUBELET_HOSTNAME=\"--hostname-override=centos-minion${MINION_NO}\"" /etc/kubernetes/kubelet
  sed -i '/KUBELET_API_SERVER/c\KUBELET_API_SERVER="--api-servers=http://centos-master:8080"' /etc/kubernetes/kubelet
  sed -i 's/\(KUBELET_POD_INFRA_CONTAINER.*\)/# \1/' /etc/kubernetes/kubelet
}

function enable-and-start-services()
{
  systemctl enable kube-proxy kubelet docker
  systemctl start kube-proxy kubelet docker
}

function main()
{
  configure-kubelet

  enable-and-start-services
}

main
