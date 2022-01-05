# ping from client11 to all 

# SRL Commands
echo -en "\n"
echo -en "showing status of the bgp neighbors"
docker exec pod1-dcgw1 sr_cli 'show network-instance default protocols bgp neighbor'

echo -en "\n"
sleep 1

echo -en "\n"
echo -en "showing status of the bgp neighbors"
docker exec pod2-dcgw1 sr_cli 'show network-instance default protocols bgp neighbor'

echo -en "\n"
sleep 1



