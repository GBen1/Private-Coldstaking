# PRIVATE COLDSTAKING V1.0

This script allows you to anonymize automatically your coldstaking rewards on your node and to redirect them automatically to the balance of your choice to your wallet. Receive your rewards in any of the three PART coin privacy states:

- Public
- Blind (Confidential Transactions)
- Anonymous (RingCT) `recommended`

> **If you already have a coldstaking node installed**, this script will transform it into a private coldstaking node. **If you don't have a coldstaking node installed yet**, this script will create it.

**Notes**

- The anonymization cycles vary from 1 to 32767 seconds.
- The amounts in each anonymization cycle vary from `<your coldstaking balance> × 0.00007 × 1` to `1.5`
- The amounts in each transfer cycle vary from `<your coldstaking balance> × 0.00006 × 1` to `1.5`

## DOWNLOAD

`git clone https://github.com/GBen1/Private-Coldstaking.git`

## INSTALL/REINSTALL

`bash privatecoldstaking.sh`

## UNINSTALL

`bash uninstall.sh`

## UPDATE YOUR NODE & GET NODE INFOS

`bash update.sh` OR `bash watch_update.sh`

## VERIFY ACTIVE SCRIPTS & COLDSTAKING BALANCE

`bash verify.sh`

## TUTORIALS

`cat Tutorials.txt`

## DEBUG

`bash log.sh`
