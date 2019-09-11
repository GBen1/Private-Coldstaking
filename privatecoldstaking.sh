#!/bin/bash

wallet(){
cd 
cd particlcore 
echo "enter a public address generated from your desktop/qt/copat wallet where you want to receive your anonymized coins:" 
read wallet
echo "$wallet" > wallet.txt 
}
