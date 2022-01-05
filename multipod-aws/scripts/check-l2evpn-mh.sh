# ping from client112 to all 
sleep 1
echo -en "ping from client112 to client212\t"
echo -en "\n"

docker exec multipod-aws-client112 bash -c 'ping -c 8 10.1.1.212'

echo -en "\n"
sleep 1

echo -en "ping from client212 to client112\n"
echo -en "\n"

docker exec multipod-aws-client212 bash -c 'ping -c 8 10.1.1.112'

echo -en "\n"
sleep 1

# SRL Commands
echo -en "\n"
echo -en "showing evpn routes type 1 \n"
docker exec multipod-aws-pod1-leaf1 sr_cli 'show network-instance default protocols bgp routes evpn route-type 1 summary'

echo -en "\n"
sleep 1

echo -en "\n"
echo -en "showing evpn routes type 4 \n"
docker exec multipod-aws-pod1-leaf1 sr_cli 'show network-instance default protocols bgp routes evpn route-type 4 summary'

echo -en "\n"
echo -en "LEAF1 showing mac-vrf bridge table type\n"

docker exec multipod-aws-pod1-leaf1 sr_cli 'show network-instance mac_vrf_10 bridge-table mac-table all '
echo -en "\n"
sleep 1

echo -en "\n"
echo -en "LEAF2 showing mac-vrf bridge table type\n"

docker exec multipod-aws-pod1-leaf2 sr_cli 'show network-instance mac_vrf_10 bridge-table mac-table all '
echo -en "\n"
sleep 1

