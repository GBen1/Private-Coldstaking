#!/bin/bash

clear
echo "ACTIVE SCRIPTS"
echo ""

chps=$(ps -ef | grep bash | grep parttoanon | cut -c49- | wc -c)

if ((chps > 1 ));
then
ps -ef | grep bash | grep parttoanon | cut -c49-
echo ""
fi


chps=$(ps -ef | grep bash | grep anontopart | cut -c49- | wc -c)

if ((chps > 1 ));
then
ps -ef | grep bash | grep anontopart | cut -c49-
echo ""
fi


chps=$(ps -ef | grep bash | grep anontoblind | cut -c49- | wc -c)

if ((chps > 1 ));
then
ps -ef | grep bash | grep anontoblind | cut -c49-
echo ""
fi


chps=$(ps -ef | grep bash | grep anontoanon | cut -c49- | wc -c)

if ((chps > 1 ));
then
ps -ef | grep bash | grep anontoanon | cut -c49-
echo ""
fi
