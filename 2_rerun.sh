#!/usr/bin/env bash
#running bash 4
#################################
# reset=$(tput sgr0); black=$(tput setaf 0);blue=$(tput setaf 33);
# cyan=$(tput setaf 37);green=$(tput setaf 64);orange=$(tput setaf 166);
# purple=$(tput setaf 125);red=$(tput setaf 124);violet=$(tput setaf 61);
# white=$(tput setaf 15);yellow=$(tput setaf 136);
# #################################
# startTime=`date "+%I:%M %p"`
# #################################
# cd "$HOME/Pictures/0gram"
# ################################
# loginflag="F"
# ################################
# #<-----------------------------------------------------------
# #check if the program is being run on the 1st or the 15th ...
# date_check=`date "+%D" | cut -d "/" -f 2`
#
# if [[ $date_check == "01" || $date_check == "15" ]];then
#    $HOME/scripts/gram/6_profile-status-checker.sh;
# fi
# #################################
# if [[ -f ".dead_profiles.txt" ]]; then
#   echo -n "Delete dead profiles? Enter y -> yes else any key -> no, 3 secounds until Timeout:"
#   read -t 3 keypress
#   while IFS= read -r line
#   do
#     if [[ $keypress == 'y' ]]; then rm -rf $line; else clear && printf '\e[3J'; fi
#   done < ".dead_profiles.txt"
# fi
# #################################
# #created list of items in dir
# ls -d */ | cut -f1 -d'/' | sort > ".gramList.txt"
# #################################
# #removes items from gen list that require login
# if [[ -f ".loginUsed.txt" ]];then
#   grep -vf ".loginUsed.txt" ".gramList.txt" > ".temp.txt"
#   cat ".temp.txt" > ".gramList.txt"
#   rm ".temp.txt"
#   loginflag="T"
# fi
# ################################
# #check for current save state and update index
# if [[ -f ".current_state.txt" ]]; then
#     cat ".current_state.txt" > ".gramList.txt"
#     rm ".current_state.txt" ".done_state.txt"
# fi
# #################################
# #loop through input list and update save state
# while IFS= read -r line
# do
#      #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#      echo ${red}"$line"${reset}; echo
#      $HOME/scripts/gram/1_main.sh "$line"
#      $HOME/scripts/gram/9_timer.sh 00 00 01
#      clear && printf '\e[3J'; echo
#      #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#      echo "$line" >> ".done_state.txt"
#      join -v1 -v2 ".gramList.txt" ".done_state.txt" > ".current_state.txt"
#      #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#      echo ${yellow}"Next download start's in 1 seconds"${Reset}
#      $HOME/scripts/gram/9_timer.sh 00 00 01 && echo && echo
#      #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# done < ".gramList.txt"
# #################################
# #check if all input files have been looked at-?
# if cmp --silent -- ".gramList.txt" ".done_state.txt"; then
#   rm ".gramList.txt" ".done_state.txt" ".current_state.txt"
# fi
# #################################
# #login in and download
# if [[ $loginflag == "T" ]]; then $HOME/scripts/gram/3_rerun-login.sh; fi
# #################################
# #prints out start and finish time and etc
# clear && printf '\e[3J'
# echo ${green}"All Downloads Complete"${reset}
# endTime=`date "+%I:%M %p"`; echo
# echo ${orange}"startTime:$startTime"${reset}
# echo ${orange}"endTime:$endTime"${Reset}

if [[ ! -d ".git" ]];then
    echo "# instaloader-related" >> README.md
    git init
    git add README.md
    git commit -m "first commit"
    git branch -M main
    git remote add origin git@github.com:ms766/instaloader-related.git
    git push -u origin main
else
  git pull
  git status
  if [[ `git status | grep -o "Untracked files"` != "" ]]; then
     git add .
     git commit -m "`date`"
     git push -u origin main
     git status
  fi
fi
