#!/bin/bash

yel='\e[1;33m'
neutre='\e[0;m'
gr='\e[1;32m'
red='\e[1;31m'
bl='\e[1;36m'
flred='\e[1;41m'

# print few first lines of readme.md

clear
readme=$(cat README.md | tac | sed "1,28d" | tac)
echo -e "\033[40m\033[1m$readme\033[0m"
echo ""
echo ""
read -p "$(echo -e "\033[40m\033[1m Press [Enter] key to continue...\033[0m")"
readme=$(cat README.md |  sed "1,16d")

cd

# kill running scripts first..

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
rm errorscriptcs.txt
cd

clear

echo "_________________________________________________________"
echo ""
echo ":: Updating repos, packages and installing dependencies.."
echo ""

#apt-get install sudo -y
#sudo apt update -y && sudo apt -y upgrade
#sudo apt install -y netcat-openbsd python git unzip pv jq dnsutils bc python-pip python-qrcode
#sudo pip install qrcode[pil]

apt install bc <<< y

apt-get install sudo -y

sudo apt-get -y install netcat-openbsd <<< y

sudo apt-get update && sudo apt-get upgrade <<< y

sudo apt-get install python git unzip pv jq <<< y

sudo apt-get install python git unzip pv jq dnsutils <<< y

sudo apt install bc <<< y

sudo apt install python-pip <<< y

sudo pip install qrcode[pil] <<< y

sudo apt install python-qrcode <<< y

sudo apt install python3-qrcode <<< y


clear

echo "_________________________________________________________"
echo ""
echo ":: Installing Partyman staking utility.."
echo ""

cd ~ && git clone https://github.com/dasource/partyman

cd && cd partyman

yes | ./partyman install

clear

yes | ./partyman restart now

checkpartyman=$(./partyman status | grep YES | wc -c)

if [[ "$checkpartyman" -lt 1 ]] ; then
cd
cd particlcore
./particl-cli stop
echo -e "${flred}ERROR: PARTYMAN INSTALL/RESTART FAILED${neutre}" >> errorscriptcs.txt
date >> errorscriptcs.txt
echo ""  >> errorscriptcs.txt
echo " - Close any other partyman session on this vps/rpi and try again" >> errorscriptcs.txt
echo "" >> errorscriptcs.txt
echo " - Verify that ./particld is up and running and that partyman is working correctly" >> errorscriptcs.txt
echo "" >> errorscriptcs.txt
echo " - If you are not on Unbuntu or Debian thanks to install manually the following dependencies: netcat-openbsd python git unzip pv jq dnsutils bc python-pip python-qrcode" >> errorscriptcs.txt
echo "" >> errorscriptcs.txt
echo " - We are maybe working on this repository currently, thanks to try again latter" >> errorscriptcs.txt
echo "" >> errorscriptcs.txt
echo "" >> errorscriptcs.txt
echo -e "${flred}Help channel:${neutre}" >> errorscriptcs.txt
echo "" >> errorscriptcs.txt
echo -e "https://t.me/particlhelp" >> errorscriptcs.txt
echo -e "https://discord.gg/RrkZmC4" >> errorscriptcs.txt
echo "" >> errorscriptcs.txt
cd
cd Private-Coldstaking
bash log.sh
exit
fi


while [ "$checkinit" != "35" ]
do
clear
./partyman stakingnode init
cd && cd particlcore 
rewardaddress=$(./particl-cli getnewaddress) 
checkinit=$(echo "$rewardaddress" | wc -c)  
cd && cd partyman
done

cd && cd partyman

echo "_________________________________________________________"
echo ""
echo ":: Updating Partyman to latest version.."
echo ""

git pull

clear

yes | ./partyman update

clear

while [[ ! "$sendto" =~ ^(private)$ ]] && [[ ! "$sendto" =~ ^(blind)$ ]] && [[ ! "$sendto" =~ ^(public)$ ]]
do
clear
echo -e "${yel}Do you want to receive your anonymized coins on the public, blind, or private balance of your wallet ? ${neutre}"
echo -e "[${gr}public${neutre}/${bl}blind${neutre}/${red}private${neutre}]"
read sendto
done

if [ $sendto = "public" ]
then

while [ "$numcharaddress" != "35" ]
do
clear
cd && cd particlcore  
echo -e "${yel}Enter a public address generated from your Desktop/Qt/Copay wallet, this address will be the reception address for your anonymized rewards:${neutre}" && read wallet
numcharaddress=$(echo "$wallet" | wc -c)
done

extkey=$(./particl-cli extkey account | grep PPART | wc -l)
while [ "$extkey" -lt "6" ]
do
./particl-cli getnewextaddress
extkey=$(($extkey + 1))
done

while [[ ! "$yesno" =~ ^(yes)$ ]] && [[ ! "$yesno" =~ ^(no)$ ]] && [[ ! "$yesno" =~ ^(y)$ ]] && [[ ! "$yesno" =~ ^(n)$ ]]
do
clear
echo -e "${yel}Do you want to update your node automatically every 12 hours ? ${neutre}"
echo -e "[${gr}yes${neutre}/${red}no${neutre}]"
read yesno
done

if [ $yesno = "yes" ] || [ $yesno = "y" ]
then
echo "bash -c 'while true;do cd && cd partyman && git pull && yes | ./partyman update; sleep 43200s; done'" > script3.sh
nohup bash script3.sh </dev/null >nohup.out 2>nohup.err &
fi

./particl-cli walletsettings stakingoptions "{\"rewardaddress\":\"$rewardaddress\"}"

stealthaddressnode=$(./particl-cli getnewstealthaddress) 

csbalance=$(./particl-cli getcoldstakinginfo | grep coin_in_cold| cut -c34- | rev | cut -c2- | rev | sed 's/ //')
csbal=$(echo $csbalance | cut -d "." -f 1 | cut -d "," -f 1)
csbalfin=$(echo $csbalance | cut -d "." -f 1 | cut -d "," -f 1)

ratio1=0.00007
ratio2=0.00006

entro=$(awk -v seed="$RANDOM" 'BEGIN { srand(seed);  printf("%.4f\n", rand()) }')
entro=$(printf '%.3f\n' "$(echo "$entro" | sed 's/','/./' | bc -l)")
entro=$(printf '%.3f\n' "$(echo "$entro" "*" "1000" | bc -l)")
entro=$(printf '%.3f\n' "$(echo "$entro" "+" "1000" | bc -l)")
entro=$(echo "$entro" | cut -d "." -f 1 | cut -d "," -f 1)

if [[ "$entro" -gt 1500 ]] ; then

        entro=$(echo "$entro" "-" "500" | bc -l)
fi

entro=$(printf '%.3f\n' "$(echo "$entro" "/" "1000" | bc -l)")


while ((csbal < 1))
do
clear
echo -e "${yel}Enter the number of coins that you want to coldstake on this node:${neutre}" && read csbal
csbal=$(echo $csbal | cut -d "." -f 1 | cut -d "," -f 1 | tr -d [a-zA-Z]| sed -n '/^[[:digit:]]*$/p' )
done

amount1=$(printf '%.3f\n' "$(echo "$csbal" "*" "$ratio1" "*" "$entro" | bc -l)")
amount2=$(printf '%.3f\n' "$(echo "$csbal" "*" "$ratio2" "*" "$entro" | bc -l)")

echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && ./particl-cli sendparttoanon $stealthaddressnode $amount1; sleep $[$RANDOM+1]s; done' " > script1.sh

echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && ./particl-cli sendanontopart $wallet $amount2; sleep $[$RANDOM+1]s; done'" > script2.sh

time1=$(cat script1.sh | cut -c188- | rev | cut -d "p" -f 1 | rev | cut -d ";" -f 1 | cut -c2- | cut -d "s" -f 1)
time1X=$(echo $time1|nawk '{printf "%02d h %02d m %02d s \n",$1/3600,$1%3600/60,$1%60}')

time2=$(cat script2.sh | cut -c120- | rev | cut -d "p" -f 1 | rev | cut -d ";" -f 1 | cut -c2- | cut -d "s" -f 1)
time2X=$(echo $time2|nawk '{printf "%02d h %02d m %02d s \n",$1/3600,$1%3600/60,$1%60}')

nohup bash script1.sh & nohup bash script2.sh </dev/null >nohup.out 2>nohup.err &
clear
clear
clear
clear
echo -e "${gr}PARTICL PRIVATE COLDSTAKING  ${neutre}"
echo "PARTICL PRIVATE COLDSTAKING " > contractprivatecs.txt
echo ""
echo ""
echo "" >> contractprivatecs.txt
echo "" >> contractprivatecs.txt
extaddress=$(./particl-cli  extkey account | tail -n 15 | grep PPART | cut -c17- | rev | cut -c3- | rev)
checkextaddress=$(./particl-cli  extkey account | tail -n 15 | grep PPART | cut -c17- | rev | cut -c3- | rev | wc -c)
if [[ "$checkextaddress" -ne 113 ]] ;
then
extaddress=$(./particl-cli getnewextaddress)
fi
echo -e "${yel}This is your coldstaking node public key, copy past it in your wallet to initialize the coldstaking smartcontract:${neutre}"
echo "This is your coldstaking node public key, copy past it in your wallet to initialize the coldstaking smartcontract:" >> contractprivatecs.txt
echo ""
echo "" >> contractprivatecs.txt
echo -e "${gr}$extaddress ${neutre}"
echo "$extaddress" >> contractprivatecs.txt
echo ""
python3-qr $extaddress 2>/dev/null
echo ""
echo "" >> contractprivatecs.txt
echo "" >> contractprivatecs.txt
echo -e "${yel}Every${neutre}${gr} $time1X${neutre}${yel}, the node is going to anonymize${neutre}${gr} $amount1 parts${neutre}${yel} from your available coldstaking rewards on this address: ${neutre}${gr}$rewardaddress${neutre}${yel} to the anon balance of your node.${neutre}"
echo "Every $time1X, the node is going to anonymize $amount1 parts from your available coldstaking rewards on this address: $rewardaddress to the anon balance of your node." >> contractprivatecs.txt
echo ""
echo "" >> contractprivatecs.txt
echo ""
echo -e "${yel}Every${neutre}${gr} $time2X${neutre}${yel}, the node is going to send you back${neutre}${gr} $amount2 parts${neutre}${yel} from the available anon balance of your node to this public address: ${neutre}${gr}$wallet${neutre}"
echo ""
echo "" >> contractprivatecs.txt
echo "Every $time2X, the node is going to send you back $amount2 parts from the available anon balance of your node to this public address: $wallet" >> contractprivatecs.txt
echo "" >> contractprivatecs.txt
echo ""

mv contractprivatecs.txt ../Private-Coldstaking/contract.txt

fi


if [ $sendto = "private" ]
then

while [ "$numcharaddress" != "103" ]
do
clear
cd && cd particlcore  
echo -e "${yel}Enter a private address (stealth address) generated from your Desktop/Qt wallet, this address will be the reception address for your coldstaking rewards:${neutre}" && read wallet
numcharaddress=$(echo "$wallet" | wc -c)
done

extkey=$(./particl-cli extkey account | grep PPART | wc -l)
while [ "$extkey" -lt "6" ]
do
./particl-cli getnewextaddress
extkey=$(($extkey + 1))
done

while [[ ! "$yesno" =~ ^(yes)$ ]] && [[ ! "$yesno" =~ ^(no)$ ]] && [[ ! "$yesno" =~ ^(y)$ ]] && [[ ! "$yesno" =~ ^(n)$ ]]
do
clear
echo -e "${yel}Do you want to update your node automatically every 12 hours ? ${neutre}"
echo -e "[${gr}yes${neutre}/${red}no${neutre}]"
read yesno
done

if [ $yesno = "yes" ] || [ $yesno = "y" ]
then
echo "bash -c 'while true;do cd && cd partyman && git pull && yes | ./partyman update; sleep 43200s; done'" > script3.sh
nohup bash script3.sh </dev/null >nohup.out 2>nohup.err &
fi

./particl-cli walletsettings stakingoptions "{\"rewardaddress\":\"$rewardaddress\"}"

stealthaddressnode=$(./particl-cli getnewstealthaddress) 

csbalance=$(./particl-cli getcoldstakinginfo | grep coin_in_cold| cut -c34- | rev | cut -c2- | rev | sed 's/ //')
csbal=$(echo $csbalance | cut -d "." -f 1 | cut -d "," -f 1)
csbalfin=$(echo $csbalance | cut -d "." -f 1 | cut -d "," -f 1)

ratio1=0.00007
ratio2=0.00006

entro=$(awk -v seed="$RANDOM" 'BEGIN { srand(seed);  printf("%.4f\n", rand()) }')
entro=$(printf '%.3f\n' "$(echo "$entro" | sed 's/','/./' | bc -l)")
entro=$(printf '%.3f\n' "$(echo "$entro" "*" "1000" | bc -l)")
entro=$(printf '%.3f\n' "$(echo "$entro" "+" "1000" | bc -l)")
entro=$(echo "$entro" | cut -d "." -f 1 | cut -d "," -f 1)

if [[ "$entro" -gt 1500 ]] ; then

        entro=$(echo "$entro" "-" "500" | bc -l)
fi

entro=$(printf '%.3f\n' "$(echo "$entro" "/" "1000" | bc -l)")

while ((csbal < 1))
do
clear
echo -e "${yel}Enter the number of coins that you want to coldstake on this node:${neutre}" && read csbal
csbal=$(echo $csbal | cut -d "." -f 1 | cut -d "," -f 1 | tr -d [a-zA-Z]| sed -n '/^[[:digit:]]*$/p' )
done

amount1=$(printf '%.3f\n' "$(echo "$csbal" "*" "$ratio1" "*" "$entro" | bc -l)")
amount2=$(printf '%.3f\n' "$(echo "$csbal" "*" "$ratio2" "*" "$entro" | bc -l)")

echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && ./particl-cli sendparttoanon  $stealthaddressnode $amount1; sleep $[$RANDOM+1]s; done' " > script1.sh
echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && ./particl-cli sendanontoanon $wallet $amount2; sleep $[$RANDOM+1]s; done' " > script2.sh

time1=$(cat script1.sh | cut -c188- | rev | cut -d "p" -f 1 | rev | cut -d ";" -f 1 | cut -c2- | cut -d "s" -f 1)
time1X=$(echo $time1|nawk '{printf "%02d h %02d m %02d s \n",$1/3600,$1%3600/60,$1%60}')

time2=$(cat script2.sh | cut -c120- | rev | cut -d "p" -f 1 | rev | cut -d ";" -f 1 | cut -c2- | cut -d "s" -f 1)
time2X=$(echo $time2|nawk '{printf "%02d h %02d m %02d s \n",$1/3600,$1%3600/60,$1%60}')

nohup bash script1.sh & nohup bash script2.sh </dev/null >nohup.out 2>nohup.err &
clear
clear
clear
clear
echo -e "${gr}PARTICL PRIVATE COLDSTAKING ${neutre}"
echo "PARTICL PRIVATE COLDSTAKING " > contractprivatecs.txt
echo ""
echo ""
echo "" >> contractprivatecs.txt
echo "" >> contractprivatecs.txt
extaddress=$(./particl-cli  extkey account | tail -n 15 | grep PPART | cut -c17- | rev | cut -c3- | rev)
checkextaddress=$(./particl-cli  extkey account | tail -n 15 | grep PPART | cut -c17- | rev | cut -c3- | rev | wc -c)
if [[ "$checkextaddress" -ne 113 ]] ;
then
extaddress=$(./particl-cli getnewextaddress)
fi
echo -e "${yel}This is your coldstaking node public key, copy past it in your wallet to initialize the coldstaking smartcontract:${neutre}"
echo "This is your coldstaking node public key, copy past it in your wallet to initialize the coldstaking smartcontract:" >> contractprivatecs.txt
echo ""
echo "" >> contractprivatecs.txt
echo -e "${gr}$extaddress ${neutre}"
echo "$extaddress" >> contractprivatecs.txt
echo ""
python3-qr $extaddress 2>/dev/null
echo ""
echo "" >> contractprivatecs.txt
echo "" >> contractprivatecs.txt
echo -e "${yel}Every${neutre}${gr} $time1X${neutre}${yel}, the node is going to anonymize${neutre}${gr} $amount1 parts${neutre}${yel} from your available coldstaking rewards on this address: ${neutre}${gr}$rewardaddress${neutre}${yel} to the anon balance of your node.${neutre}" 
echo "Every $time1X, the node is going to anonymize $amount1 parts from your available coldstaking rewards on this address: $rewardaddress to the anon balance of your node." >> contractprivatecs.txt
echo ""
echo ""
echo "" >> contractprivatecs.txt
echo "" >> contractprivatecs.txt
echo -e "${yel}Every${neutre}${gr} $time2X${neutre}${yel}, the node is going to send you back${neutre}${gr} $amount2 parts${neutre}${yel} from the available anon balance of your node to the anon balance of your wallet.${neutre}" 
echo "Every $time2X, the node is going to send you back $amount2 parts from the available anon balance of your node to the anon balance of your wallet." >> contractprivatecs.txt
echo "" >> contractprivatecs.txt
echo ""

mv contractprivatecs.txt ../Private-Coldstaking/contract.txt

fi


if [ $sendto = "blind" ]
then

while [ "$numcharaddress" != "103" ]
do
clear
cd && cd particlcore && echo -e "${yel}Enter a private address (stealth address) generated from your Desktop/Qt wallet, this address will be the reception address for your coldstaking rewards:${neutre}" && read wallet
numcharaddress=$(echo "$wallet" | wc -c)
done

extkey=$(./particl-cli extkey account | grep PPART | wc -l)
while [ "$extkey" -lt "6" ]
do
./particl-cli getnewextaddress
extkey=$(($extkey + 1))
done

while [[ ! "$yesno" =~ ^(yes)$ ]] && [[ ! "$yesno" =~ ^(no)$ ]] && [[ ! "$yesno" =~ ^(y)$ ]] && [[ ! "$yesno" =~ ^(n)$ ]]
do
clear
echo -e "${yel}Do you want to update your node automatically every 12 hours ? ${neutre}"
echo -e "[${gr}yes${neutre}/${red}no${neutre}]"
read yesno
done

if [ $yesno = "yes" ] || [ $yesno = "y" ]
then
echo "bash -c 'while true;do cd && cd partyman && git pull && yes | ./partyman update; sleep 43200s; done'" > script3.sh
nohup bash script3.sh </dev/null >nohup.out 2>nohup.err &
fi

./particl-cli walletsettings stakingoptions "{\"rewardaddress\":\"$rewardaddress\"}"

stealthaddressnode=$(./particl-cli getnewstealthaddress) 

csbalance=$(./particl-cli getcoldstakinginfo | grep coin_in_cold| cut -c34- | rev | cut -c2- | rev | sed 's/ //')
csbal=$(echo $csbalance | cut -d "." -f 1 | cut -d "," -f 1)
csbalfin=$(echo $csbalance | cut -d "." -f 1 | cut -d "," -f 1)

ratio1=0.00007
ratio2=0.00006

entro=$(awk -v seed="$RANDOM" 'BEGIN { srand(seed);  printf("%.4f\n", rand()) }')
entro=$(printf '%.3f\n' "$(echo "$entro" | sed 's/','/./' | bc -l)")
entro=$(printf '%.3f\n' "$(echo "$entro" "*" "1000" | bc -l)")
entro=$(printf '%.3f\n' "$(echo "$entro" "+" "1000" | bc -l)")
entro=$(echo "$entro" | cut -d "." -f 1 | cut -d "," -f 1)

if [[ "$entro" -gt 1500 ]] ; then

        entro=$(echo "$entro" "-" "500" | bc -l)
fi

entro=$(printf '%.3f\n' "$(echo "$entro" "/" "1000" | bc -l)")


while ((csbal < 1))
do
clear
echo -e "${yel}Enter the number of coins that you want to coldstake on this node:${neutre}" && read csbal
csbal=$(echo $csbal | cut -d "." -f 1 | cut -d "," -f 1 | tr -d [a-zA-Z]| sed -n '/^[[:digit:]]*$/p' )
done

amount1=$(printf '%.3f\n' "$(echo "$csbal" "*" "$ratio1" "*" "$entro" | bc -l)")
amount2=$(printf '%.3f\n' "$(echo "$csbal" "*" "$ratio2" "*" "$entro" | bc -l)")

echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && ./particl-cli sendparttoanon $stealthaddressnode $amount1; sleep $[$RANDOM+1]s; done' " > script1.sh

echo "bash -c 'while true;do ./particl-cli settxfee 0.002 && ./particl-cli sendanontoblind $wallet $amount2; sleep $[$RANDOM+1]s; done'" > script2.sh

time1=$(cat script1.sh | cut -c188- | rev | cut -d "p" -f 1 | rev | cut -d ";" -f 1 | cut -c2- | cut -d "s" -f 1)
time1X=$(echo $time1|nawk '{printf "%02d h %02d m %02d s \n",$1/3600,$1%3600/60,$1%60}')

time2=$(cat script2.sh | cut -c120- | rev | cut -d "p" -f 1 | rev | cut -d ";" -f 1 | cut -c2- | cut -d "s" -f 1)
time2X=$(echo $time2|nawk '{printf "%02d h %02d m %02d s \n",$1/3600,$1%3600/60,$1%60}')

nohup bash script1.sh & nohup bash script2.sh </dev/null >nohup.out 2>nohup.err &
clear
clear
clear
clear
echo -e "${gr}PARTICL PRIVATE COLDSTAKING ${neutre}"
echo "PARTICL PRIVATE COLDSTAKING " > contractprivatecs.txt
echo ""
echo ""
echo "" >> contractprivatecs.txt
echo "" >> contractprivatecs.txt
extaddress=$(./particl-cli  extkey account | tail -n 15 | grep PPART | cut -c17- | rev | cut -c3- | rev)
checkextaddress=$(./particl-cli  extkey account | tail -n 15 | grep PPART | cut -c17- | rev | cut -c3- | rev | wc -c)
if [[ "$checkextaddress" -ne 113 ]] ;
then
extaddress=$(./particl-cli getnewextaddress)
fi
echo -e "${yel}This is your coldstaking node public key, copy past it in your wallet to initialize the coldstaking smartcontract:${neutre}"
echo "This is your coldstaking node public key, copy past it in your wallet to initialize the coldstaking smartcontract:" >> contractprivatecs.txt
echo ""
echo "" >> contractprivatecs.txt
echo -e "${gr}$extaddress ${neutre}"
echo "$extaddress" >> contractprivatecs.txt
echo ""
python3-qr $extaddress 2>/dev/null
echo ""
echo "" >> contractprivatecs.txt
echo "" >> contractprivatecs.txt
echo -e "${yel}Every${neutre}${gr} $time1X${neutre}${yel}, the node is going to anonymize${neutre}${gr} $amount1 parts${neutre}${yel} from your available coldstaking rewards on this address: ${neutre}${gr}$rewardaddress${neutre}${yel} to the anon balance of your node.${neutre}"
echo "Every $time1X, the node is going to anonymize $amount1 parts from your available coldstaking rewards on this address: $rewardaddress to the anon balance of your node." >> contractprivatecs.txt
echo ""
echo ""
echo -e "${yel}Every${neutre}${gr} $time2X${neutre}${yel}, the node is going to send you back${neutre}${gr} $amount2 parts${neutre}${yel} from the available anon balance of your node to the blind balance of your wallet.${neutre}" 
echo "" >> contractprivatecs.txt
echo "" >> contractprivatecs.txt
echo "Every $time2X, the node is going to send you back $amount2 parts from the available anon balance of your node to the blind balance of your wallet." >> contractprivatecs.txt
echo "" >> contractprivatecs.txt
echo ""

mv contractprivatecs.txt ../Private-Coldstaking/contract.txt

fi

checkamount1=$(printf '%.3f\n' "$(echo "$amount1" "*" "1000" | bc -l)")
checkamount1=$(echo "$checkamount1" | cut -d "." -f 1 | cut -d "," -f 1)

checkamount2=$(printf '%.3f\n' "$(echo "$amount2" "*" "1000" | bc -l)")
checkamount2=$(echo "$checkamount2" | cut -d "." -f 1 | cut -d "," -f 1)

if [ $checkamount1 -lt 20 ] || [ $checkamount2 -lt 20 ] || ([ $checkamount1 -lt 20 ] && [ $checkamount2 -lt 20 ]); then

[ -f contractprivatecs.txt ] && rm contractprivatecs.txt

cd
cd Private-Coldstaking
rm contract.txt


clear
cd
cd partyman
echo -e "y\ " | ./partyman stakingnode rewardaddress
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
clear
clear
echo -e "${flred}ERROR: AMOUNT${neutre}"
echo ""
echo ""
echo -e "${flred}The script failed:${neutre}"
echo ""
echo -e "${flred} - Verify that bc is installed: sudo apt install bc ${neutre}"
echo ""
echo -e "${flred} - If you have less than 500parts you should join a pool: https://particl.wiki/learn/staking/pools ${neutre}"
echo ""
echo -e "${flred} - If you have already delegated less than 500parts to this node and you want to add more funds thanks to cancel the pre-existing smartcontract in sending your funds to a new standard address in your wallet before running this script again ${neutre}"
echo ""
echo -e "${flred} - Debug: bash log.sh ${neutre}"
echo ""
echo ""
echo -e "${flred}Help channel:${neutre}"
echo ""
echo -e "${flred}https://t.me/particlhelp${neutre}"
echo -e "${flred}https://discord.gg/RrkZmC4${neutre}"
echo ""



echo "ERROR AMOUNT"  >> errorscriptcs.txt
date >> errorscriptcs.txt
echo ""  >> errorscriptcs.txt
echo "csbal = $csbal , norm: [350 - inf]" >> errorscriptcs.txt
echo "entropy = $entro, norm: [1 - 1.5]" >> errorscriptcs.txt
echo "ratio1 = $ratio1, norm: [0.00007]" >> errorscriptcs.txt
echo "ratio2 = $ratio2, norm: [0.00006]" >> errorscriptcs.txt
echo "amount1 = csbal * entropy * ratio1 = $amount1, norm: [0.021 - inf]" >> errorscriptcs.txt
echo "amount2 = csbal * entropy * ratio2 = $amount2, norm: [0.021 - inf]" >> errorscriptcs.txt
echo "" >> errorscriptcs.txt
echo "" >> errorscriptcs.txt

else

echo ""
read -p "$(echo -e ${gr}Press [Enter] key to continue...${neutre})"
clear
echo -e "\033[40m\033[1mPRIVATE COLDSTAKING \033[0m"
echo ""
echo -e "\033[40m\033[1m$readme\033[0m"
echo ""

fi


