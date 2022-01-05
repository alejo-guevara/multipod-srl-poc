#!/bin/bash

# multipod-aws-client134

docker exec multipod-aws-client134 bash -c 'ip link add bond0 type bond miimon 100 mode 802.3ad lacp_rate slow'
docker exec multipod-aws-client134 bash -c 'ip link set eth1 down'
docker exec multipod-aws-client134 bash -c 'ip link set eth2 down'
docker exec multipod-aws-client134 bash -c 'ip link set bond0 down'
docker exec multipod-aws-client134 bash -c 'ip link set eth1 master bond0'
docker exec multipod-aws-client134 bash -c 'ip link set eth2 master bond0'
docker exec multipod-aws-client134 bash -c 'ip link set bond0 up'
docker exec multipod-aws-client134 bash -c 'ip link set eth1 up'
docker exec multipod-aws-client134 bash -c 'ip link set eth2 up'
docker exec multipod-aws-client134 bash -c 'ip route del default'
docker exec multipod-aws-client134 bash -c 'ip a add 20.1.1.134/24 dev bond0'
docker exec multipod-aws-client134 bash -c 'ip route add default via 20.1.1.1'


# multipod-aws-client234

docker exec multipod-aws-client234 bash -c 'ip link add bond0 type bond miimon 100 mode 802.3ad lacp_rate slow'
docker exec multipod-aws-client234 bash -c 'ip link set eth1 down'
docker exec multipod-aws-client234 bash -c 'ip link set eth2 down'
docker exec multipod-aws-client234 bash -c 'ip link set bond0 down'
docker exec multipod-aws-client234 bash -c 'ip link set eth1 master bond0'
docker exec multipod-aws-client234 bash -c 'ip link set eth2 master bond0'
docker exec multipod-aws-client234 bash -c 'ip link set bond0 up'
docker exec multipod-aws-client234 bash -c 'ip link set eth1 up'
docker exec multipod-aws-client234 bash -c 'ip link set eth2 up'
docker exec multipod-aws-client234 bash -c 'ip route del default'
docker exec multipod-aws-client234 bash -c 'ip a add 20.1.1.234/24 dev bond0'
docker exec multipod-aws-client234 bash -c 'ip route add default via 20.1.1.1'
