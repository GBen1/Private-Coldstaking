#!/bin/bash

cd
script1=$(ps -ef | grep bash | grep script1.sh | sed 's/.*-c//')
num=$(echo $script1 | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep script1.sh | cut -c10-14 | sed -n "1p") && sudo kill -9 $kill $(( x++ )); done

script2=$(ps -ef | grep bash | grep script2.sh | sed 's/.*-c//')
num=$(echo $script2 | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep script2.sh | cut -c10-14 | sed -n "1p") && sudo kill -9 $kill $(( x++ )); done

parttoanon=$(ps -ef | grep bash | grep sendparttoanon | sed 's/.*-c//')
num=$(echo $parttoanon | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep sendparttoanon | cut -c10-14 | sed -n "1p") && sudo kill -9 $kill $(( x++ )); done

anontopart=$(ps -ef | grep bash | grep anontopart | sed 's/.*-c//')
num=$(echo $anontopart | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep sendanontopart | cut -c10-14 | sed -n "1p") && sudo kill -9 $kill $(( x++ )); done

anontoblind=$(ps -ef | grep bash | grep anontoblind | sed 's/.*-c//')
num=$(echo $anontoblind | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep sendanontoblind | cut -c10-14 | sed -n "1p") && sudo kill -9 $kill $(( x++ )); done

anontoanon=$(ps -ef | grep bash | grep anontoanon | sed 's/.*-c//')
num=$(echo $anontoanon | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep sendanontoanon | cut -c10-14 | sed -n "1p") && sudo kill -9 $kill $(( x++ )); done

script3=$(ps -ef | grep bash | grep script3.sh| sed 's/.*-c//')
num=$(echo $script3 | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep script3.sh | cut -c10-14 | sed -n "1p") && sudo kill -9 $kill $(( x++ )); done

update=$(ps -ef | grep bash | grep "partyman update" | sed 's/.*-c//')
num=$(echo $update | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep "partyman update" | cut -c10-14 | sed -n "1p") && sudo kill -9 $kill $(( x++ )); done

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
