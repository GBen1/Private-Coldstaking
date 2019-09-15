clear
echo "ACTIVE SCRIPTS"
echo ""
ps -ef | grep bash | grep parttoanon | cut -c49-
echo ""
ps -ef | grep bash | grep anontopart | cut -c49-
echo ""
