#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

echo "==> Configuring global fallback DNS for systemd-resolved..."
mkdir -p /etc/systemd/resolved.conf.d

cat <<EOF > /etc/systemd/resolved.conf.d/fallback-dns.conf
[Resolve]
FallbackDNS=8.8.8.8 1.1.1.1
EOF

systemctl restart systemd-resolved
