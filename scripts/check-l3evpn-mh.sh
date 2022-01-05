# ping from client134 to client234 
sleep 1
echo -en "ping from client134 to client234\t"
echo -en "\n"

docker exec multipod-aws-client134 bash -c 'ping -c 10 20.1.1.234'

echo -en "\n"
sleep 1

sleep 1
echo -en "ping from client234 to client134\t"
echo -en "\n"

docker exec multipod-aws-client234 bash -c 'ping -c 10 20.1.1.134'

echo -en "\n"
sleep 1


# SRL Commands
echo -en "\n"
echo -en "showing evpn routes type 5 \n"
docker exec multipod-aws-pod1-leaf3 sr_cli 'show network-instance default protocols bgp routes evpn route-type 5 summary'

echo -en "\n"
sleep 1

echo -en "\n"
echo -en "showing mac-vrf bridge table type\n"


docker exec multipod-aws-pod1-leaf3 sr_cli 'show network-instance mac_vrf_20 bridge-table mac-table all '
echo -en "\n"
sleep 1

echo -en "\n"
echo -en "showing mac-vrf bridge table type\n"


docker exec multipod-aws-pod1-leaf4 sr_cli 'show network-instance mac_vrf_20 bridge-table mac-table all '
echo -en "\n"
sleep 1

echo -en "\n"
echo -en "showing arpnd for IRB\n"
docker exec multipod-aws-pod1-leaf3 sr_cli 'show arpnd arp-entries interface irb0'
echo -en "\n"
