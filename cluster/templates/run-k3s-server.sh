#!/usr/bin/env bash

set -ue

ZEROTIER_IF=TODO
ZEROTIER_IP=TODO
export K3S_TOKEN=RANDOM:RANDOM:RANDOM

exec /usr/local/bin/k3s server    \
	--kubelet-arg='address=0.0.0.0' \
	--node-ip $ZEROTIER_IP          \
	--disable traefik               \
	--flannel-iface $ZEROTIER_IF    \
	--tls-san $ZEROTIER_IP --tls-san 127.0.0.1
