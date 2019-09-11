cd && cd particlcore && echo " enter a public address generated from your desktop/qt/copat wallet where you want to receive your anonymized coins:" && read wallet
rewardaddress=$(cd && cd particlcore && ./particl-cli getnewaddress) 
cd && cd particlcore && ./particl-cli walletsettings stakingoptions "{\"rewardaddress\":\"$rewardaddress\"}"
cd && cd particlcore && stealthaddressnode=$(./particl-cli getnewstealthaddress) && echo "$stealthaddressnode" > stealthaddressnode.txt
echo "$wallet" > wallet.txt 
echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && random=$(echo $(( RANDOM % (100 - 50 + 1 ) + 50 ))) && stealthaddressnode=$(cat stealthaddressnode.txt) && ./particl-cli sendparttoanon $stealthaddressnode 0.45; sleep $random ; done' " > script1.sh
echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && random=$(echo $(( RANDOM % (100 - 50 + 1 ) + 50 ))) && wallet=$(cat wallet.txt) && ./particl-cli sendanontopart $wallet 0.4; sleep $random; done'" > script2.sh
nohup bash script1.sh & nohup bash script2.sh
