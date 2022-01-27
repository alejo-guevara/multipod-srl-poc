#!/bin/bash

# client12
docker exec client12 bash -c 'ip a add 20.1.1.12/24 dev eth1'
docker exec client12 bash -c 'ip route del default'
docker exec client12 bash -c 'ip route add default via 20.1.1.1'

# client14
docker exec client14 bash -c 'ip a add 20.1.1.14/24 dev eth1'
docker exec client14 bash -c 'ip route del default'
docker exec client14 bash -c 'ip route add default via 20.1.1.1'


# client22
docker exec client22 bash -c 'ip a add 20.1.1.22/24 dev eth1'
docker exec client22 bash -c 'ip route del default'
docker exec client22 bash -c 'ip route add default via 20.1.1.1'

# client24
docker exec client24 bash -c 'ip a add 20.1.1.24/24 dev eth1'
docker exec client24 bash -c 'ip route del default'
docker exec client24 bash -c 'ip route add default via 20.1.1.1'

