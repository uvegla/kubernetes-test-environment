#!/bin/bash

function install-etcd()
{
  yum install -y etcd
}

function configure-kubernetes-apiserver()
{
  sed -i '/KUBE_API_ADDRESS/c\KUBE_API_ADDRESS="--address=0.0.0.0"' /etc/kubernetes/apiserver
  sed -i '/KUBE_API_PORT/c\KUBE_API_PORT="--port=8080"' /etc/kubernetes/apiserver
  sed -i '/KUBELET_PORT/c\KUBELET_PORT="--kubelet-port=10250"' /etc/kubernetes/apiserver
  sed -i 's/\(KUBE_ADMISSION_CONTROL.*\)/# \1/' /etc/kubernetes/apiserver
}

function configure-etcd()
{
  sed -i '/ETCD_LISTEN_CLIENT_URLS/c\ETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379"' /etc/etcd/etcd.conf
  sed -i '/ETCD_ADVERTISE_CLIENT_URLS/c\ETCD_ADVERTISE_CLIENT_URLS="http://0.0.0.0:2379"' /etc/etcd/etcd.conf
}

function enable-and-start-services()
{
  systemctl enable etcd ntpd kube-apiserver kube-controller-manager kube-scheduler docker
  systemctl start etcd ntpd kube-apiserver kube-controller-manager kube-scheduler docker
}

function main()
{
  install-etcd

  configure-kubernetes-apiserver
  configure-etcd

  enable-and-start-services
}

main
