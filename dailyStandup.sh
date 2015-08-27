#!/bin/bash

today=`date "+%m_%d_%y" | grep -oe "\d_\d\d_\d\d$"` # leading zeroes are annoying for folder names
yesterday=`date -v -1d "+%m_%d_%y" | grep -oe "\d_\d\d_\d\d$"`

# Open up work log files needed for the daily standup

vimSetupScript=/tmp/vimDailyLogSetup.vscript


# -------------------------
# |           |            |
# | yesterday |            |
# |           |            |
# |           |    today   |
# |           |            |
# |           |            |
# |-----------|            |
# | yesterday |            |
# | EOD w-i-p |            |
# --------------------------

if [[ -e $vimSetupScript ]] ; then rm $vimSetupScript; fi
echo ":view ~/log/daily/$today/log.txt" > $vimSetupScript
sed -i -e '$a\'$'\n'':vnew' $vimSetupScript
sed -i -e '$a\'$'\n'":view ~/log/daily/$yesterday/workInProgress.txt"$'\n' $vimSetupScript
sed -i -e '$a\'$'\n'':new' $vimSetupScript
sed -i -e '$a\'$'\n'":view ~/log/daily/$yesterday/log.txt"$'\n' $vimSetupScript
mvim -s $vimSetupScript
