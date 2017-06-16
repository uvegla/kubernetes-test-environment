#!/bin/bash

function configure-hosts()
{
  echo "172.168.96.100 master" >> /etc/hosts

  echo "172.168.96.111 minion-1" >> /etc/hosts
  echo "172.168.96.112 minion-2" >> /etc/hosts
  echo "172.168.96.113 minion-3" >> /etc/hosts
}

function add-repo-virt7-docker-common-release-repo()
{
  tee /etc/yum.repos.d/virt7-docker-common-release.repo <<EOF
[virt7-docker-common-release]
name=virt7-docker-common-release
baseurl=http://cbs.centos.org/repos/virt7-docker-common-release/x86_64/os/
gpgcheck=0
EOF

  yum update -y
}

function install-ntp()
{
  yum install -y ntp
}

function install-docker-and-kubernetes()
{
  yum install -y --enablerepo=virt7-docker-common-release docker kubernetes
}

function configure-docker()
{
  groupadd docker

  usermod -aG docker vagrant
}

function configure-kubernetes()
{
  sed -i '/KUBE_MASTER/c\KUBE_MASTER="--master=http://master:8080"' /etc/kubernetes/config

  echo >> /etc/kubernetes/config
  echo 'KUBE_ETCD_SERVERS="--etcd-servers=http://master:2379"' | tee -a /etc/kubernetes/config
}

function stop-services()
{
  systemctl stop iptables || echo "iptables was not running"
  systemctl stop firewalld || echo "firewalld was not running"
}

function main()
{
  stop-services

  add-repo-virt7-docker-common-release-repo

  install-ntp
  install-docker-and-kubernetes

  configure-hosts
  configure-docker
  configure-kubernetes
}

main
