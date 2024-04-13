#!/usr/bin/env bash

set -ue

ZEROTIER_IF=TODO
ZEROTIER_IP=TODO # OR: ZEROTIER_IP=$(ip addr show $ZEROTIER_IF|grep -w 'inet' | cut -d' ' -f6 | cut -d/ -f1)
MASTER_IP=TODO
export K3S_TOKEN=RANDOM:RANDOM:RANDOM

exec /usr/local/bin/k3s agent  \
	--node-ip $ZEROTIER_IP       \
	--flannel-iface $ZEROTIER_IF \
	--server https://$MASTER_IP:6443
