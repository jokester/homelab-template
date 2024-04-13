# Homelab

Configurations for my homelab cluster.

## cluster: setup of k3s-over-zerotier cluster

- initialize nodes: `cloud-init`
- run `k3s server` or `k3s agent`: systemd

## monitoring

- blackbox observability: [grafana cloud](https://grafana.com/)

<!--
- whitebox monitoring: baselime?
-->

## connectivity

cloudflared, to expose services to Internet or VPN.

(inter-node and inter-pod connectivity already provided by the cluster itself)

## playground: run a test k3s cluster with [docker-compose](https://github.com/k3s-io/k3s/blob/master/docker-compose.yml)

