#!/bin/bash
if [ "$1" == "-p" ]; then
	vpnpreserve=1
fi
##predefined vars##
#counter for hostname list
servnum=1
locnum=1
echo "-------------------List of Customers---------------------"
#Display list
locations=($(grep '^group=' ~/.local/share/remmina/* | sed 's/group=//' | sed 's/.*remmina://' | sort -d --unique | sed '/^[[:space:]]*$/d'))
for i in "${locations[@]}"
do
#if [ echo "$i" | wc -c < 10]
#   $i="$i\t"
#fi


    listvpn=$(nmcli con | grep vpn |sed 's/ .*//'| grep -i "$i")
    echo -e  "$locnum\t$i\t$listvpn"
    let "locnum+=1"
done
echo "-------------------------------------------------------"
#Promt User choise and read into variable
echo "Protip: wwcon -p to perserve vpn connection"
echo "Case insensitive"
printf "Specify Customer number:"
read locpick
echo "-------------------------------------------------------"
let "locpick-=1"
tgtcus=${locations[$locpick]}


#String to figure out RDP filename for RDP
#session and further queries on file
#grep -iRl "group=$query" ~/.local/share/remmina | sed 's/.*remmina\///'
echo -e "Number:\tHostname:\tAddress:\tUsername:"
targets=($(grep -iRl  "group=$tgtcus" ~/.local/share/remmina | sed 's/.*remmina\///')) 
for i in "${targets[@]}"
do
	 hostname=$(grep '^name=' ~/.local/share/remmina/$i | sed 's/name=//')
    server=$(grep '^server=' ~/.local/share/remmina/$i | sed 's/server=//')
    username=$(grep '^username=' ~/.local/share/remmina/$i | sed 's/username=//')
    echo -e "$servnum\t$hostname\t$server\t$username"    
    let "servnum+=1" 

done
#gthostssh=($(grep -iR -B4 '^# group' ~/.ssh/config))
#for i in "${tgthostssh[@]}"
#do
#    echo $i
#    echo "BØØØØØØØØ"
#done


echo "-------------------------------------------------------"
printf "Pick Number host you want to connect to:"
read pick
echo "-------------------------------------------------------"
let "pick-=1" 
tgtfile=${targets[$pick]}

#find target location vpn
tgtvpn=$(nmcli con | grep vpn |sed 's/ .*//'| grep -i "$tgtcus")
#find vpn to kill
vpnkills=($(nmcli con show --active | grep vpn |sed 's/ .*//'))


#Checks if target site VPN is Active.
#If so do nothing
#Else kill vpn and activate target site vpn
if checkvpnactive=$(nmcli con show --active | grep vpn | grep -i $tgtcus) || [ "$vpnpreserve" > "1" ]
then 
   if [ "$vpnpreserve" > "1" ]
   then
      echo "Activating $tgtvpn vpn"
      nmcli connection up id $tgtvpn
      echo "-------------------------------------------------------"
   else
      echo "$tgtvpn vpn is already active"
      echo "-------------------------------------------------------"
   fi
else
   for i in "${vpnkills[@]}"
   do
       echo "Killing $i vpn"
       nmcli connection down id $i
       echo "-------------------------------------------------------"
   done
   echo "Activating $tgtvpn vpn"
   nmcli connection up id $tgtvpn
   echo "-------------------------------------------------------"
fi

#Activate RDP Session
echo -e "Starting RDP session to $hostname"
remmina ~/.local/share/remmina/$tgtfile > /dev/null 2>&1  &
echo "-------------------------------------------------------"

	