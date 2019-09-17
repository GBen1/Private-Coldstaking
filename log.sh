#!/bin/bash

cd
clear
cd particlcore
[ -f  errorscriptcs.txt ] && cat  errorscriptcs.txt
echo ""
echo "NOHUP.OUT"
echo ""
tail -n 10 nohup.out 
echo ""
echo "NOHUP.ERR"
echo ""
tail -n 10 nohup.err
echo ""
