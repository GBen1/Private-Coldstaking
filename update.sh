neutre='\e[0;m'
gr='\e[1;32m'
cy='\e[0;36m'
bl='\e[1;36m'
yel='\e[1;33m'

git pull
contract=$(cat contract.txt | sed "1,2d")
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
contractprivatecs=$(cat contractprivatecs.txt | sed "1,2d")
clear
echo -e "${gr}NODE BALANCES${neutre}"
echo ""
network=$(./particl-cli getstakinginfo | sed 's/"//' | sed 's/"//' |sed 's/,//' | cut -c3-)
balances=$(./particl-cli getwalletinfo | sed "1,3d" | tac | sed "1,9d" | tac | sed 's/"//' | sed 's/"//' |sed 's/,//' | cut -c3- | rev | cut -c6- | rev )
echo -e "${yel}$balances${neutre}"
echo ""
echo ""
echo -e ${gr}NETWORK INFOS${neutre}"
echo ""
echo -e "${yel}$network${neutre}"
echo ""
echo ""
echo -e "${gr}PRIVATE COLDSTAKING CONTRACT${neutre}"
echo -e "${yel}$contract${neutre}"
echo -e "${yel}$contractprivatecs${neutre}"
echo ""
echo ""
echo -e "${gr}ACTIVE SCRIPTS${neutre}"
parttoanon=$(ps -ef | grep bash | grep parttoanon | cut -c49-)
echo ""
echo -e "${yel}$parttoanon${neutre}"
anontopart=$(ps -ef | grep bash | grep anontopart | cut -c49-)
echo ""
echo -e "${yel}$anontopart${neutre}"
anontoblind=$(ps -ef | grep bash | grep anontoblind | cut -c49-)
echo ""
echo -e "${yel}$anontoblind${neutre}"
