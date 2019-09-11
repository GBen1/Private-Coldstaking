yel='\e[1;33m'
neutre='\e[0;m'


cd && cd particlcore && echo -e "${yel}Enter a public address generated from your Desktop/Qt/Copay wallet, this address will be the reception address for your anonymized rewards:${neutre}" && read wallet

rewardaddress=$(cd && cd particlcore && ./particl-cli getnewaddress) 

cd && cd particlcore && ./particl-cli walletsettings stakingoptions "{\"rewardaddress\":\"$rewardaddress\"}"

cd && cd particlcore && stealthaddressnode=$(./particl-cli getnewstealthaddress) && echo "$stealthaddressnode" > stealthaddressnode.txt

echo "$wallet" > wallet.txt 

echo -e "${yel}Your rewards are going to be anonymized on your coldstakingnode (from this address: $rewardaddress), afterward they will be automatically sent back to you on this address: $wallet ${neutre}"

echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && random=$(echo $(( RANDOM % (100 - 50 + 1 ) + 50 ))) && stealthaddressnode=$(cat stealthaddressnode.txt) && ./particl-cli sendparttoanon $stealthaddressnode 0.45; sleep $random ; done' " > script1.sh

echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && random=$(echo $(( RANDOM % (100 - 50 + 1 ) + 50 ))) && wallet=$(cat wallet.txt) && ./particl-cli sendanontopart $wallet 0.4; sleep $random; done'" > script2.sh

nohup bash script1.sh & nohup bash script2.sh
