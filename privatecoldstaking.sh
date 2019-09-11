yel='\e[1;33m'
neutre='\e[0;m'
gr='\e[1;32m'

cd

sudo apt-get update && sudo apt-get upgrade

sudo apt-get install python git unzip pv jq

cd ~ && git clone https://github.com/dasource/partyman

cd partyman/

./partyman install

./partyman restart now

./partyman stakingnode init

cd && cd particlcore && echo -e "${yel}Enter a public address generated from your Desktop/Qt/Copay wallet, this address will be the reception address for your anonymized rewards:${neutre}" && read wallet

echo "$wallet" > wallet.txt 

rewardaddress=$(./particl-cli getnewaddress) 

extaddress=$(./particl-cli getnewextaddress)

./particl-cli walletsettings stakingoptions "{\"rewardaddress\":\"$rewardaddress\"}"

stealthaddressnode=$(./particl-cli getnewstealthaddress) 

echo "$stealthaddressnode" > stealthaddressnode.txt

echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && random=$(echo $(( RANDOM % (100 - 50 + 1 ) + 50 ))) && stealthaddressnode=$(cat stealthaddressnode.txt) && ./particl-cli sendparttoanon $stealthaddressnode 0.45; sleep $random ; done' " > script1.sh

echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && random=$(echo $(( RANDOM % (100 - 50 + 1 ) + 50 ))) && wallet=$(cat wallet.txt) && ./particl-cli sendanontopart $wallet 0.4; sleep $random; done'" > script2.sh

echo -e "${yel}Your coldstaking rewards are going to be anonymized on your coldstakingnode (from this address:${neutre} ${gr} $rewardaddress ${neutre} ${yel}), afterward they will be automatically sent back to you on this address:${neutre} ${gr} $wallet ${neutre}"
echo ""
echo -e "${yel}This is your coldstaking node public key, copy past it in your wallet to initialize the coldstaking smartcontract: ${neutre} ${gr} $extaddress ${neutre}"
echo ""

nohup bash script1.sh & nohup bash script2.sh
