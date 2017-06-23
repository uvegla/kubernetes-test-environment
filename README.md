# Kubernetes test environment

Alternative to [Minikube](https://kubernetes.io/docs/getting-started-guides/minikube/).

## Requirements

* Vagrant - [Installation guide](https://www.vagrantup.com/docs/installation/)

## Infrastucture

| Server | Vagrant ssh | IP Address |
| --- | --- | --- |
| Master | vagrant ssh master | 172.168.96.100 |
| Minion 1 | vagrant ssh minion-1 | 172.168.96.111 |
| Minion 2 | vagrant ssh minion-2 | 172.168.96.112 |
| Minion 3 | vagrant ssh minion-3 | 172.168.96.113 |

## Usage

Build your infrastructure.

```bash
vagrant up
```

Jump into the master node.

```bash
vagrant ssh master
```

Test your infrastructure.

```bash
kubectl get nodes
```

## Tear down infrastructure

Execute the following snippet in the project's root directory.

```bash
vagrant destroy
```
