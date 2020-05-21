#!/bin/bash

cd
script1=$(ps -ef | grep bash | grep script1.sh | cut -c10-16)
num=$(echo $script1 | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep script1.sh  | sed -n "1p" | cut -c10-16) && sudo kill -9 $kill $(( x++ )); done

script2=$(ps -ef | grep bash | grep script2.sh | cut -c10-16)
num=$(echo $script2 | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep script2.sh  | sed -n "1p" | cut -c10-16) && sudo kill -9 $kill $(( x++ )); done

parttoanon=$(ps -ef | grep bash | grep sendparttoanon | cut -c10-16)
num=$(echo $parttoanon | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep sendparttoanon  | sed -n "1p" | cut -c10-16) && sudo kill -9 $kill $(( x++ )); done

anontopart=$(ps -ef | grep bash | grep anontopart | cut -c10-16)
num=$(echo $anontopart | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep sendanontopart  | sed -n "1p" | cut -c10-16) && sudo kill -9 $kill $(( x++ )); done

anontoblind=$(ps -ef | grep bash | grep anontoblind | cut -c10-16)
num=$(echo $anontoblind | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep sendanontoblind  | sed -n "1p" | cut -c10-16) && sudo kill -9 $kill $(( x++ )); done

anontoanon=$(ps -ef | grep bash | grep anontoanon | cut -c10-16)
num=$(echo $anontoanon | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep sendanontoanon  | sed -n "1p" | cut -c10-16) && sudo kill -9 $kill $(( x++ )); done

script3=$(ps -ef | grep bash | grep script3.sh | cut -c10-16)
num=$(echo $script3 | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep script3.sh  | sed -n "1p" | cut -c10-16) && sudo kill -9 $kill $(( x++ )); done

update=$(ps -ef | grep bash | grep "partyman update" | cut -c10-16)
num=$(echo $update | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep "partyman update"  | sed -n "1p" | cut -c10-16) && sudo kill -9 $kill $(( x++ )); done

cd particlcore
rm wallet.txt
rm stealthaddressnode.txt
rm script1.sh
rm script2.sh
rm nohup.out
rm nohup.err
rm contractprivatecs.txt
cd

cd Private-Coldstaking
rm contract.txt
cd

cd partyman
clear
echo -e "y\ " | ./partyman stakingnode rewardaddress
