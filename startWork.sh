#!/bin/bash

# Insert existence check for work logs folder here
today=`date "+%m_%d_%y" | grep -oe "\d_\d\d_\d\d$"` # leading zeroes are annoying for folder names
yesterday=`date -v -1d "+%m_%d_%y" | grep -oe "\d_\d\d_\d\d$"`

# It's a new day!
mkdir ~/log/daily/$today

echo "Daily Work Log for $today"$'\n--------------------------' > /tmp/workLogHeader.txt
cat /tmp/workLogHeader.txt ~/Work/Templates/misc/DailyLog.txt > ~/log/daily/$today/log.txt

echo "Work in-progress at EOD $today:"$'\n\n' > ~/log/daily/$today/workInProgress.txt

# Open up my work log files how I like them in macvim
if [[ -e /tmp/vimDailyLogSetup.vscript ]] ; then rm /tmp/vimDailyLogSetup.vscript; fi
echo ':new' > /tmp/vimDailyLogSetup.vscript
sed -i -e '$a\'$'\n'":edit ~/log/daily/$today/log.txt" /tmp/vimDailyLogSetup.vscript
sed -i -e '$a\'$'\n'':new' /tmp/vimDailyLogSetup.vscript
sed -i -e '$a\'$'\n'":edit ~/log/daily/$yesterday/workInProgress.txt"$'\n' /tmp/vimDailyLogSetup.vscript

mvim ~/log/daily/$today/workInProgress.txt -s /tmp/vimDailyLogSetup.vscript
