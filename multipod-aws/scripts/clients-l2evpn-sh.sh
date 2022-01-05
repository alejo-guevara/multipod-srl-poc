#!/bin/bash

docker exec multipod-aws-client11 bash -c 'ip a add 10.1.1.11/24 dev eth1'
docker exec multipod-aws-client13 bash -c 'ip a add 10.1.1.13/24 dev eth1'

docker exec multipod-aws-client21 bash -c 'ip a add 10.1.1.21/24 dev eth1'
docker exec multipod-aws-client23 bash -c 'ip a add 10.1.1.23/24 dev eth1'
