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

while [ "$numcharaddress" != "35" ]
do
clear
cd && cd particlcore && echo -e "${yel}Enter a public address generated from your Desktop/Qt/Copay wallet, this address will be the reception address for your anonymized rewards:${neutre}" && read wallet
numcharaddress=$(echo "$wallet" | wc -c)
done
echo "$wallet" > wallet.txt 

rewardaddress=$(./particl-cli getnewaddress) 

extaddress=$(./particl-cli getnewextaddress)

./particl-cli walletsettings stakingoptions "{\"rewardaddress\":\"$rewardaddress\"}"

stealthaddressnode=$(./particl-cli getnewstealthaddress) 

echo "$stealthaddressnode" > stealthaddressnode.txt

csbalance=$(./particl-cli getcoldstakinginfo | grep coin_in_cold | cut -c35-44)
csbal=$(echo $csbalance | cut -d "." -f 1 | cut -d "," -f 1)
csbalfin=$(echo $csbalance | cut -d "." -f 1 | cut -d "," -f 1)

ratio1=0.00007
ratio2=0.00006

while ((csbal < 1))
do
clear
echo -e "${yel}Enter the number of coins that you want to coldstake on this node:${neutre}" && read csbal
csbal=$(echo $csbal | cut -d "." -f 1 | cut -d "," -f 1 | tr -d [a-zA-Z]| sed -n '/^[[:digit:]]*$/p' )
done

amount1=$(printf '%.3f\n' "$(echo "$csbal" "*" "$ratio1" | bc -l)")
amount2=$(printf '%.3f\n' "$(echo "$csbal" "*" "$ratio2" | bc -l)")

echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && stealthaddressnode=$(cat stealthaddressnode.txt) && ./particl-cli sendparttoanon $stealthaddressnode $amount1; sleep $[$RANDOM+1]s; done' " > script1.sh

echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && wallet=$(cat wallet.txt) && ./particl-cli sendanontopart $wallet $amount2; sleep $[$RANDOM+1]s; done'" > script2.sh

time1=$(cat script1.sh | cut -c313- | rev | cut -d "p" -f 1 | rev | cut -d ";" -f 1 | cut -c2- | cut -d "s" -f 1)
time2=$(cat script2.sh | cut -c165- | rev | cut -d "p" -f 1 | rev | cut -d ";" -f 1 | cut -c2- | cut -d "s" -f 1)

clear

echo -e "${gr}PARTICL PRIVATE COLDSTAKING ${neutre}"
echo "PARTICL PRIVATE COLDSTAKING" > contractprivatecs.txt
echo ""
echo ""
echo "" >> contractprivatecs.txt
echo "" >> contractprivatecs.txt
if ((csbalfin < 1 ));
then
echo -e "${yel}This is your coldstaking node public key, copy past it in your wallet to initialize the coldstaking smartcontract:${neutre}"
echo "This is your coldstaking node public key, copy past it in your wallet to initialize the coldstaking smartcontract:" >> contractprivatecs.txt
echo ""
echo "" >> contractprivatecs.txt
echo -e "${gr}$extaddress ${neutre}"
echo "$extaddress" >> contractprivatecs.txt
echo ""
echo ""
echo "" >> contractprivatecs.txt
echo "" >> contractprivatecs.txt
fi
echo -e "${yel}Every${neutre}${gr} $time1 seconds${neutre}${yel}, the node is going to anonymize${neutre}${gr} $amount1 parts${neutre}${yel} from this public address ${neutre}${gr}$rewardaddress${neutre}${yel} to the anon balance of your node.${neutre}"
echo "Every $time1 seconds, the node is going to anonymize $amount1 parts from this public address $rewardaddress to the anon balance of your node." >> contractprivatecs.txt
echo ""
echo "" >> contractprivatecs.txt
echo -e "${yel}Every${neutre}${gr} $time2 seconds${neutre}${yel}, the node is going to send you back${neutre}${gr} $amount2 parts${neutre}${yel} from the available anon balance of your node to this public address: ${neutre}"
echo -e "${gr}$wallet ${neutre]"
echo "Every $time2 seconds, the node is going to send you back $amount2 parts from the available anon balance of your node to this public address: $wallet$" >> contractprivatecs.txt
echo "$wallet" >> contractprivatecs.txt
echo ""
echo ""
echo -e "${yel}Press${neutre} ${gr}ENTER${neutre} ${yel}to finalize this process${neutre}"
echo ""

mv /root/particlcore/contractprivatecs.txt /root/Private-Coldstaking/contract.txt

nohup bash script1.sh & nohup bash script2.sh </dev/null >nohup.out 2>nohup.err &




