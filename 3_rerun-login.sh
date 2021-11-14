#!/usr/bin/env bash
#running bash 4
#################################
reset=$(tput sgr0); black=$(tput setaf 0);blue=$(tput setaf 33);
cyan=$(tput setaf 37);green=$(tput setaf 64);orange=$(tput setaf 166);
purple=$(tput setaf 125);red=$(tput setaf 124);violet=$(tput setaf 61);
white=$(tput setaf 15);yellow=$(tput setaf 136);
#################################
if [[ ! -f ".temp_login_state.txt" ]]; then cat ".loginUsed.txt" > ".temp_login_state.txt"; fi
#################################
#check for current save state and update index
if [[ -f ".login_current_state.txt" ]]; then
    cat ".login_current_state.txt" > ".temp_login_state.txt"
    rm ".login_current_state.txt" ".login_done_state.txt"
fi
#################################
#loop through input list and update save state
while IFS= read -r line
do
     #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
     echo ${red}"$line"${reset}; echo
     $HOME/scripts/gram/1_main.sh "login" "$line"
     $HOME/scripts/gram/9_timer.sh 00 00 60
     clear && printf '\e[3J'; echo
     #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
     echo "$line" >> ".login_done_state.txt"
     join -v1 -v2 ".temp_login_state.txt" ".login_done_state.txt" > ".login_current_state.txt"
     #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
     echo ${yellow}"Next download start's in 1 seconds"${Reset}
     $HOME/scripts/gram/9_timer.sh 00 00 60 && echo && echo
     #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
done < ".temp_login_state.txt"
#################################
#check if all input files have been looked at-?
if cmp --silent -- ".temp_login_state.txt" ".login_done_state.txt"; then
  rm ".temp_login_state.txt" ".login_done_state.txt" ".login_current_state.txt"
fi
