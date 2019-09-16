#!/bin/bash

neutre='\e[0;m'
gr='\e[1;32m'
yel='\e[1;33m'

clear

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


anonttoblind=$(ps -ef | grep bash | grep anonttoblind | cut -c49-)
chps=$(echo $anonttoblind | wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$anonttoblind${neutre}"
fi


anontopart=$(ps -ef | grep bash | grep anontopart | cut -c49-)
chps=$(echo $anontopart| wc -c)
if ((chps > 1 ));
then
echo ""
echo -e "${yel}$anontopart${neutre}"
fi

echo ""
