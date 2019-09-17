#!/bin/bash

neutre='\e[0;m'
gr='\e[1;32m'
yel='\e[1;33m'
flred='\e[1;41m'


clear
contract=$(cat contract.txt | sed "1,2d")

cd
cd particlcore
[ -f contractprivatecs.txt ] && contractprivatecs=$(cat contractprivatecs.txt | sed "1,2d") 
csb=$(./particl-cli getcoldstakinginfo | grep coin_in_cold | cut -c35-44 | cut -d "." -f 1 | cut -d "," -f 1)
clear
clear
echo -e "${gr}COLDSTAKING BALANCE${neutre}"
echo ""
echo -e "${yel}$csb PARTS${neutre}"
echo ""
echo -e "${gr}PRIVATE COLDSTAKING CONTRACT${neutre}"
echo -e "${yel}$contract${neutre}"
echo -e "${yel}$contractprivatecs${neutre}"
echo ""

echo -e "${gr}ACTIVE SCRIPTS${neutre}"

a=0
parttoanon=$(ps -ef | grep bash | grep parttoanon | cut -c49-)
chps=$(echo $parttoanon | wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$parttoanon${neutre}"
a=1
fi

anontoanon=$(ps -ef | grep bash | grep anontoanon | cut -c49-)
chps=$(echo $anontoanon | wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$anontoanon${neutre}"
a=2
fi


anontoblind=$(ps -ef | grep bash | grep anontoblind | cut -c49-)
chps=$(echo $anontoblind | wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$anontoblind${neutre}"
a=2

fi


anontopart=$(ps -ef | grep bash | grep anontopart | cut -c49-)
chps=$(echo $anontopart| wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$anontopart${neutre}"
a=2
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
