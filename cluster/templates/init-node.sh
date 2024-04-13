#!/usr/bin/env bash
if [[ -f /root/init-node.log ]] ; then
  exit 0
fi

exec 1>>/root/init-node.log 2>>/root/init-node.log
set -uex

echo "====starting==== $(date)"

apt-get purge -y snapd || echo 'snapd not installed'

curl -s https://install.zerotier.com | bash
apt-get update

# basic shell + trouble shooting utils
apt-get install -y wget screen tmux zsh git vim-nox pv htop iotop strace sysstat dnsutils software-properties-common ca-certificates rsync curl

# a subset of https://www.brendangregg.com/blog/2024-03-24/linux-crisis-tools.html
apt-get install -y procps util-linux sysstat iproute2 numactl tcpdump nicstat ethtool bpfcc-tools cpuid

#### Zerotier
apt-get install -y zerotier-one

# no docker
# apt-get install -y docker.io docker-compose
# k3s bin from https://github.com/k3s-io/k3s/releases
K3S_VERSION=v1.29.3+k3s1

case "$(uname -m)" in
  "x86_64")
    wget --output-document=/usr/local/bin/k3s https://github.com/k3s-io/k3s/releases/download/$K3S_VERSION/k3s
    ;;
  "aarch64")
    wget --output-document=/usr/local/bin/k3s https://github.com/k3s-io/k3s/releases/download/$K3S_VERSION/k3s-arm64
    ;;
  *)
    echo "Unsupported architecture: $ARCH"
    ;;
esac

chmod -v +x /usr/local/bin/k3s # would fail if no k3s binary downloaded

#### setup a 1G swapfile
fallocate -l 1G /swapfile
mkswap /swapfile
chmod 000 /swapfile
swapon /swapfile
echo '/swapfile swap swap defaults 0 0' >> /etc/fstab

#### done
echo "====finishing==== $(date)"
sync
sleep 10
reboot
