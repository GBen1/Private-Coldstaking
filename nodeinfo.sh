neutre='\e[0;m'
gr='\e[1;32m'

cd
cd partyman
git pull
clear
yes | ./partyman update
clear
./partyman status
read -p "Press [Enter] key to continue..."
clear
./partyman stakingnode stats
read -p "Press [Enter] key to continue..."
clear
cd
cd particlcore
echo -e "${gr}NODE BALANCES${neutre}"
echo ""
./particl-cli getwalletinfo | sed -n '4,/tx/p' | sed "11d"
echo ""
