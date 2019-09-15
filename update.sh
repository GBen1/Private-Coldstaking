neutre='\e[0;m'
gr='\e[1;32m'
cy='\e[0;36m'

git pull
cd
cd partyman
clear
git pull
clear
yes | ./partyman update
echo ""
read -p "Press [Enter] key to continue..."
clear
./partyman status
read -p "Press [Enter] key to continue..."
clear
./partyman stakingnode stats
read -p "Press [Enter] key to continue..."
clear
cd
cd particlcore
echo -e "${cy}NODE BALANCES${neutre}"
echo ""
balances=$(./particl-cli getwalletinfo | sed -n '4,/tx/p' | sed "11d" | sed 's/"//)
echo -e "${cy}$balances${neutre}"
echo ""
