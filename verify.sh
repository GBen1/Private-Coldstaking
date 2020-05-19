#!/bin/bash

neutre='\e[0;m'
gr='\e[1;32m'
yel='\e[1;33m'
flred='\e[1;41m'

sudo apt install python-pip <<< y

sudo pip install qrcode[pil] <<< y

clear
clear

contract1=$(cat contract.txt | sed "1,2d" | tac | tail -n 5 | tac)
contract2=$(cat contract.txt | sed "1,7d" )
nodekey=$(cat contract.txt | sed "1,2d" | tac | tail -n 5 | tac | grep PPART)


cd
cd particlcore
[ -f contractprivatecs.txt ] && contractprivatecs1=$(cat contractprivatecs.txt | sed "1,2d" | tac | tail -n 5 | tac)  && contractprivatecs2=$(cat contractprivatecs.txt | sed "1,7d" ) && nodekeycs=$(cat contractprivatecs.txt | sed "1,2d" | tac | tail -n 5 | tac | grep PPART)
csb=$(./particl-cli getcoldstakinginfo | grep coin_in_cold | cut -c35-44 | cut -d "." -f 1 | cut -d "," -f 1)
clear
clear
echo -e "${gr}COLDSTAKING BALANCE${neutre}"
echo ""
echo -e "${yel}$csb PARTS${neutre}"
echo ""
echo -e "${gr}PRIVATE COLDSTAKING CONTRACT${neutre}"
echo -e "${yel}$contract1${neutre}"
echo -e "${yel}$contractprivatecs1${neutre}"
echo ""

checknodekey=$(echo $nodekey | wc -c)
if [[ "$checknodekey" -eq 113 ]] ;
then
qr --error-correction=L $nodekey
fi

checknodekeycs=$(echo $nodekeycs | wc -c)
if [[ "$checknodekeycs" -eq 113 ]] ;
then
qr --error-correction=L $nodekeycs
fi

echo -e "${yel}$contract2${neutre}"
echo -e "${yel}$contractprivatecs2${neutre}"

echo -e "${gr}ACTIVE SCRIPTS${neutre}"

a=0
parttoanon=$(ps -ef | grep bash | grep parttoanon | cut -c49-)
chps=$(echo $parttoanon | wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$parttoanon${neutre}"
((++a))
fi

anontoanon=$(ps -ef | grep bash | grep anontoanon | cut -c49-)
chps=$(echo $anontoanon | wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$anontoanon${neutre}"
((++a))
fi


anontoblind=$(ps -ef | grep bash | grep anontoblind | cut -c49-)
chps=$(echo $anontoblind | wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$anontoblind${neutre}"
((++a))

fi


anontopart=$(ps -ef | grep bash | grep anontopart | cut -c49-)
chps=$(echo $anontopart| wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$anontopart${neutre}"
((++a))
fi

autoupdate=$(ps -ef | grep bash | grep "partyman update" | cut -c49-)
chps=$(echo $autoupdate| wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$autoupdate${neutre}"
fi

if [ $a = "0" ]
then
echo ""
echo -e "${flred}THERE IS NO PC ACTIVE SCRIPT${neutre}"
fi

if [ $a = "1" ]
then
echo ""
echo -e "${flred}ERROR: THERE IS ONLY 1 PC ACTIVE SCRIPT${neutre}"
fi

echo ""
