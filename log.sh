#!/bin/bash

cd
clear
cd particlcore
[ -f  errorscriptcs.txt ] && cat  errorscriptcs.txt
echo ""
cat nohup.out
echo ""
cat nohup.err
echo ""
