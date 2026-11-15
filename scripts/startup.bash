#!/usr/bin/env bash


# Setup tap for tender

IFACE=tap0
SUBNET=10.0.0.0/24

# Create tap only if missing (idempotent across container restarts)
ip link show "$IFACE" >/dev/null 2>&1 || ip tuntap add dev "$IFACE" mode tap
ip addr show dev "$IFACE" | grep -q "inet "|| ip addr add 10.0.0.1/24 dev "$IFACE"
ip link set "$IFACE" up

iptables -t nat -C POSTROUTING -s "$SUBNET" ! -o "$IFACE" -j MASQUERADE 2>/dev/null \
    || iptables -t nat -A POSTROUTING -s "$SUBNET" ! -o "$IFACE" -j MASQUERADE

exec "$@"
