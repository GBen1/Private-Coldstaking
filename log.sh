#!/bin/bash

cd
clear
cd particlcore
[ -f  errorscriptcs.txt ] && cat  errorscriptcs.txt
echo ""
tail -n 10 nohup.out 
echo ""
tail -n 10 nohup.err
echo ""
