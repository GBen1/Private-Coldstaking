yel='\e[1;33m'
neutre='\e[0;m'
gr='\e[1;32m'

cd

script1=$(ps -ef | grep bash | grep script1.sh | cut -c10-14)
num=$(echo $script1 | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep script1.sh | cut -c10-14 | sed -n "1p") && sudo kill -9 $kill $(( x++ )); done

script2=$(ps -ef | grep bash | grep script2.sh | cut -c10-14)
num=$(echo $script2 | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep script2.sh | cut -c10-14 | sed -n "1p") && sudo kill -9 $kill $(( x++ )); done

parttoanon=$(ps -ef | grep bash | grep sendparttoanon | cut -c10-14)
num=$(echo $parttoanon | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep sendparttoanon | cut -c10-14 | sed -n "1p") && sudo kill -9 $kill $(( x++ )); done

anontopart=$(ps -ef | grep bash | grep anontopart | cut -c10-14)
num=$(echo $anontopart | wc -w)
x=1; while [ $x -le $num ]; do kill=$(ps -ef | grep bash | grep sendanontopart | cut -c10-14 | sed -n "1p") && sudo kill -9 $kill $(( x++ )); done

sudo apt-get update && sudo apt-get upgrade <<< y

sudo apt-get install python git unzip pv jq <<< y

cd ~ && git clone https://github.com/dasource/partyman

cd partyman/

yes | ./partyman install

./partyman restart now

clear

./partyman stakingnode init

git pull

yes | ./partyman update

clear

cd && cd particlcore && echo -e "${yel}Enter a public address generated from your Desktop/Qt/Copay wallet, this address will be the reception address for your anonymized rewards:${neutre}" && read wallet

echo "$wallet" > wallet.txt 

rewardaddress=$(./particl-cli getnewaddress) 

extaddress=$(./particl-cli getnewextaddress)

./particl-cli walletsettings stakingoptions "{\"rewardaddress\":\"$rewardaddress\"}"

stealthaddressnode=$(./particl-cli getnewstealthaddress) 

echo "$stealthaddressnode" > stealthaddressnode.txt

csbal=$(./particl-cli getcoldstakinginfo | grep coin_in_cold | cut -c35-48)
ratio1=0.00007
ratio2=0.00006
amount1=$(echo "$csbal" "*" "$ratio1" | bc -l)
amount2=$(echo "$csbal" "*" "$ratio2" | bc -l)

echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && stealthaddressnode=$(cat stealthaddressnode.txt) && ./particl-cli sendparttoanon $stealthaddressnode $amount1; sleep $[$RANDOM+1]s; done' " > script1.sh

echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && wallet=$(cat wallet.txt) && ./particl-cli sendanontopart $wallet $amount2; sleep $[$RANDOM+1]s; done'" > script2.sh

clear

echo -e "${gr}PARTICL PRIVATE COLDSTAKING ${neutre}"
echo ""
echo ""
echo -e "${yel}Your coldstaking rewards are going to be anonymized on your coldstakingnode (from this address:${neutre}${gr} $rewardaddress${neutre}${yel}), afterward they will be automatically sent back to you on this address:${neutre}"
echo ""
echo -e "${gr}$wallet ${neutre}"
echo ""
echo ""
echo -e "${yel}This is your new coldstaking node public key, copy past it in your wallet to initialize the coldstaking smartcontract (if you already have initialized a coldstaking smartcontract this step is optional):${neutre}"
echo ""
echo -e "${gr}$extaddress ${neutre}"
echo ""
echo ""
echo -e "${yel}Press${neutre} ${gr}ENTER${neutre} ${yel}to finalize this process${neutre}"
echo ""

nohup bash script1.sh & nohup bash script2.sh </dev/null >nohup.out 2>nohup.err &


