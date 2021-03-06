#!/bin/bash

neutre='\e[0;m'
gr='\e[1;32m'
cy='\e[0;36m'
bl='\e[1;36m'
yel='\e[1;33m'
flred='\e[1;41m'

git pull
contract=$(cat contract.txt | sed "1,2d")
cd
cd partyman
clear
git pull
clear
yes | ./partyman update
echo ""
read -p "$(echo -e ${gr}Press [Enter] key to continue...${neutre})"
clear
./partyman status
read -p "$(echo -e ${gr}Press [Enter] key to continue...${neutre})"
clear
./partyman stakingnode stats
read -p "$(echo -e ${gr}Press [Enter] key to continue...${neutre})"
clear
cd
cd particlcore
[ -f contractprivatecs.txt ] && contractprivatecs=$(cat contractprivatecs.txt | sed "1,2d") 
csb=$(./particl-cli getcoldstakinginfo | grep coin_in_cold | cut -c35-44 | cut -d "." -f 1 | cut -d "," -f 1)
var=$(./particl-cli getstakinginfo | grep expected | cut -c18-)
var=$(echo $var|nawk '{printf "%02d h %02d m %02d s \n",$1/3600,$1%3600/60,$1%60}')
clear
clear
echo -e "${gr}COLDSTAKING BALANCE${neutre}"
echo ""
echo -e "${yel}$csb PARTS${neutre}"
echo ""
echo -e "${gr}NEXT REWARD (EXPECTED)${neutre}"
echo ""
echo -e "${yel}$var${neutre}"
echo ""
echo -e "${gr}NODE BALANCES${neutre}"
echo ""
network=$(./particl-cli getstakinginfo | sed 's/"//' | sed 's/"//' |sed 's/,//' | cut -c3-)
balances=$(./particl-cli getwalletinfo | sed "1,3d" | tac | sed "1,9d" | tac | sed 's/"//' | sed 's/"//' |sed 's/,//' | cut -c3- | rev | cut -c6- | rev | sed 15d)
echo -e "${yel}$balances${neutre}"
echo ""
echo ""
echo -e "${gr}NETWORK INFOS${neutre}"
echo -e "${yel}$network${neutre}"
echo ""
echo ""
read -p "$(echo -e ${gr}Press [Enter] key to continue...${neutre})"
clear
clear
echo -e "${gr}PRIVATE COLDSTAKING CONTRACT${neutre}"
echo -e "${yel}$contract${neutre}"
echo -e "${yel}$contractprivatecs${neutre}"
echo ""
echo -e "${gr}ACTIVE SCRIPTS${neutre}"

a=0
parttoanon=$(ps -ef | grep bash | grep parttoanon |  sed 's/.*bash -c//' | cut -c2-)
chps=$(echo $parttoanon | wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$parttoanon${neutre}"
((++a))
fi

anontoanon=$(ps -ef | grep bash | grep anontoanon | sed 's/.*bash -c//' | cut -c2-)
chps=$(echo $anontoanon | wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$anontoanon${neutre}"
((++a))
fi


anontoblind=$(ps -ef | grep bash | grep anontoblind |  sed 's/.*bash -c//' | cut -c2-)
chps=$(echo $anontoblind | wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$anontoblind${neutre}"
((++a))

fi


anontopart=$(ps -ef | grep bash | grep anontopart |  sed 's/.*bash -c//' | cut -c2-)
chps=$(echo $anontopart| wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$anontopart${neutre}"
((++a))
fi

autoupdate=$(ps -ef | grep bash | grep "partyman update" | sed 's/.*bash -c//' | cut -c2-)
chps=$(echo $autoupdate| wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$autoupdate${neutre}"
fi

if [ $a = "0" ]
then
echo ""
echo -e "${flred}THERE IS NO ACTIVE SCRIPT${neutre}"
fi

if [ $a = "1" ]
then
echo ""
echo -e "${flred}ERROR: THERE IS ONLY 1 ACTIVE SCRIPT${neutre}"
fi

echo ""
