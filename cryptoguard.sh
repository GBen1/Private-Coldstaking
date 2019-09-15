cd
cd particlcore

csbalance=$(./particl-cli getcoldstakinginfo | grep coin_in_cold| cut -c34- | rev | cut -c2- | rev | sed 's/ //')
echo "csbalance "$csbalance"

csbal=$(echo $csbalance | cut -d "." -f 1 | cut -d "," -f 1)
echo "csbal $csbal"

ratio1=0.00007

echo "ratio1 = 0.0007"

entro=$(awk -v seed="$RANDOM" 'BEGIN { srand(seed);  printf("%.4f\n", rand()) }')
entro=$(printf '%.3f\n' "$(echo "$entro" | bc -l)")
entro=$(printf '%.3f\n' "$(echo "$entro" "*" "1000" | bc -l)")
entro=$(printf '%.3f\n' "$(echo "$entro" "+" "1000" | bc -l)")
entro=$(echo "$entro" | cut -d "." -f 1 | cut -d "," -f 1)

echo "entropie $entro"

amount1=$(printf '%.3f\n' "$(echo "$csbal" "*" "$ratio1" "*" "$entro" | bc -l)")

echo "amount = csbal x ratio1 x entropie = $amount1"
