# ping from client12 to all 
sleep 1
echo -en "ping from client12 to client14\t"
echo -en "\n"

docker exec client12 bash -c 'ping -c 5 20.1.1.14'

echo -en "\n"
sleep 1

echo -en "ping from client12 to client22\n"
echo -en "\n"

docker exec client12 bash -c 'ping -c 5 20.1.1.22'

echo -en "\n"
sleep 1

echo -en "ping from client12 to client24\n"
echo -en "\n"

docker exec client12 bash -c 'ping -c 5 20.1.1.24'

echo -en "\n"
sleep 1


# SRL Commands
echo -en "\n"
echo -en "showing evpn routes type 5 \n"
docker exec pod1-leaf2 sr_cli 'show network-instance default protocols bgp routes evpn route-type 5 summary'

echo -en "\n"
sleep 1

echo -en "\n"
echo -en "showing mac-vrf bridge table type\n"


docker exec pod1-leaf2 sr_cli 'show network-instance mac_vrf_20 bridge-table mac-table all '
echo -en "\n"
sleep 1

echo -en "\n"
echo -en "showing arpnd for IRB\n"
docker exec pod1-leaf2 sr_cli 'show arpnd arp-entries interface irb0'
echo -en "\n"
