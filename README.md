# Private-Coldstaking v1.0

* This script allows you to anonymize automatically your coldstaking rewards on your node and to redirect them automatically to the public balance of your wallet.
* This script allows you to redirect automatically your coldstaking rewards to the anon balance of your wallet.

* If you already have a coldstaking node, this script will transform it into a private coldstakin gnode.
* If you don't already have a coldstaking node, this script will create a Private coldstaking node.

* The anonymization cycles vary from 1 to 32767seconds.
* The amounts sent during each cycles of anonymization vary from ["your coldstakingbalance" * "0.00007" * "1.000"] to ["your coldstakingbalance" * "0.00006" * "1.500"].
* The amounts sent during each cycles of transfer to your wallet vary from ["your coldstakingbalance" * "0.00006" * "1.000"] to ["your coldstakingbalance" * "0.00006" * "1.500"].

## DOWNLOAD

`git clone https://github.com/GBen1/Private-Coldstaking.git`

## INSTALL/REINSTALL

`bash privatecoldstaking.sh`


## UNINSTALL

`bash uninstall.sh`


## CURRENT SCRIPT

`cat contract.txt`


## VERIFY ACTIVE SCRIPTS

`bash verify.sh`
