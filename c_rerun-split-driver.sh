#!/usr/bin/env bash
#running bash 4
############################################
curState=`ls | grep ".*current_state"`
glist=`echo $curState | grep -o "glistSplit.*"`
############################################
if [[ $1 == "" ]]; then
  incomingfile=$glist
else
  incomingfile=$1
fi
# ############################################
index=`echo $incomingfile | grep -o ".*[0-9]"`
# ############################################
# #check for current save state and update index
if [[ -f $curState ]]; then
  cat $curState > $glist
  find . -name 'current_state*.txt' -delete
  find . -name 'done_state*.txt' -delete
fi
# ###########################################
while IFS= read -r line
do
     #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
     echo ${red}"$line"${reset}; echo
     $HOME/scripts/gram/1_main.sh $line
     $HOME/scripts/gram/9_timer.sh 00 00 01
     clear && printf '\e[3J'; echo
     #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
     echo "$line" >> "done_state_$index.txt"
     join -v1 -v2 $incomingfile "done_state_$index.txt" > "current_state_$index.txt"
     #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
     echo ${yellow}"Next download start's in 1 seconds"${Reset}
     $HOME/scripts/gram/9_timer.sh 00 00 01 && echo && echo
     #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
done < $incomingfile
############################################
os_flag="";
if [[ "$OSTYPE" == "darwin"* ]]; then os_flag+="M"; fi
if [[ "$OSTYPE" == "linux"* ]]; then os_flag+="L"; fi
############################################
#check if all input files have been looked at
if [[ $os_flag == "M" ]];then
  find "." -size 0 -print0 | xargs -0 rm
#check if os is linux
elif [[ $os_flag == "L" ]]; then
  find "." -size  0 -print -delete
fi
############################################
if cmp --silent -- $incomingfile "done_state_$index.txt"; then
  rm $incomingfile "done_state_$index.txt"
fi
