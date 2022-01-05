# ping from client11 to all 
sleep 1
echo -en "ping from client11 to client13\t"
echo -en "\n"

docker exec client11 bash -c 'ping -c 4 10.1.1.13'

echo -en "\n"
sleep 1

echo -en "ping from client11 to client21\n"
echo -en "\n"

docker exec client11 bash -c 'ping -c 4 10.1.1.21'

echo -en "\n"
sleep 1

echo -en "ping from client11 to client23\n"
echo -en "\n"

docker exec client11 bash -c 'ping -c 4 10.1.1.23'

echo -en "\n"
sleep 1


# SRL Commands
echo -en "\n"
echo -en "showing evpn routes type 2 (mac)\n"
docker exec pod1-leaf1 sr_cli 'show network-instance default protocols bgp routes evpn route-type 2 summary'

echo -en "\n"
sleep 1

echo -en "\n"
echo -en "showing mac-vrf bridge table type\n"


docker exec pod1-leaf1 sr_cli 'show network-instance mac_vrf_10 bridge-table mac-table all '
echo -en "\n"
sleep 1

