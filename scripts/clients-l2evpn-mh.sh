#!/bin/bash

# client112

docker exec client112 bash -c 'ip link add bond0 type bond miimon 100 mode 802.3ad lacp_rate slow'
docker exec client112 bash -c 'ip link set eth1 down'
docker exec client112 bash -c 'ip link set eth2 down'
docker exec client112 bash -c 'ip link set bond0 down'
docker exec client112 bash -c 'ip link set eth1 master bond0'
docker exec client112 bash -c 'ip link set eth2 master bond0'
docker exec client112 bash -c 'ip link set bond0 up'
docker exec client112 bash -c 'ip link set eth1 up'
docker exec client112 bash -c 'ip link set eth2 up'
docker exec client112 bash -c 'ip a add 10.1.1.112/24 dev bond0'

# client212

docker exec client212 bash -c 'ip link add bond0 type bond miimon 100 mode 802.3ad lacp_rate slow'
docker exec client212 bash -c 'ip link set eth1 down'
docker exec client212 bash -c 'ip link set eth2 down'
docker exec client212 bash -c 'ip link set bond0 down'
docker exec client212 bash -c 'ip link set eth1 master bond0'
docker exec client212 bash -c 'ip link set eth2 master bond0'
docker exec client212 bash -c 'ip link set bond0 up'
docker exec client212 bash -c 'ip link set eth1 up'
docker exec client212 bash -c 'ip link set eth2 up'
docker exec client212 bash -c 'ip a add 10.1.1.212/24 dev bond0'

