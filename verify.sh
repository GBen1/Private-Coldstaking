#!/bin/bash

neutre='\e[0;m'
gr='\e[1;32m'
yel='\e[1;33m'


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

parttoanon=$(ps -ef | grep bash | grep parttoanon | cut -c49-)
chps=$(echo $parttoanon | wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$parttoanon${neutre}"
fi

anontoanon=$(ps -ef | grep bash | grep anontoanon | cut -c49-)
chps=$(echo $anontoanon | wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$anontoanon${neutre}"
fi


anontoblind=$(ps -ef | grep bash | grep anontoblind | cut -c49-)
chps=$(echo $anontoblind | wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$anontoblind${neutre}"
fi


anontopart=$(ps -ef | grep bash | grep anontopart | cut -c49-)
chps=$(echo $anontopart| wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$anontopart${neutre}"
fi

echo ""
