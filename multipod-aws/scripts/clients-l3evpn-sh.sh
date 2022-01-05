#!/bin/bash

# multipod-aws-client12
docker exec multipod-aws-client12 bash -c 'ip a add 20.1.1.12/24 dev eth1'
docker exec multipod-aws-client12 bash -c 'ip route del default'
docker exec multipod-aws-client12 bash -c 'ip route add default via 20.1.1.1'

# multipod-aws-client14
docker exec multipod-aws-client14 bash -c 'ip a add 20.1.1.14/24 dev eth1'
docker exec multipod-aws-client14 bash -c 'ip route del default'
docker exec multipod-aws-client14 bash -c 'ip route add default via 20.1.1.1'


# multipod-aws-client22
docker exec multipod-aws-client22 bash -c 'ip a add 20.1.1.22/24 dev eth1'
docker exec multipod-aws-client22 bash -c 'ip route del default'
docker exec multipod-aws-client22 bash -c 'ip route add default via 20.1.1.1'

# multipod-aws-client24
docker exec multipod-aws-client24 bash -c 'ip a add 20.1.1.24/24 dev eth1'
docker exec multipod-aws-client24 bash -c 'ip route del default'
docker exec multipod-aws-client24 bash -c 'ip route add default via 20.1.1.1'

