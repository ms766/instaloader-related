#!/usr/bin/env bash
#running bash 4
#################################
reset=$(tput sgr0); black=$(tput setaf 0);blue=$(tput setaf 33);
cyan=$(tput setaf 37);green=$(tput setaf 64);orange=$(tput setaf 166);
purple=$(tput setaf 125);red=$(tput setaf 124);violet=$(tput setaf 61);
white=$(tput setaf 15);yellow=$(tput setaf 136);
###################################################
startTime=`date "+%I:%M %p"`
###################################################
cd "$HOME/Pictures/0gram"
##################################################
loginflag="F"
##################################################
#<-----------------------------------------------------------
#check if the program is being run on the 1st or the 15th ...
date_check=`date "+%D" | cut -d "/" -f 2`

if [[ $date_check == "01" || $date_check == "15" ]];then
   $HOME/scripts/gram/6_profile-status-checker.sh;
fi
###################################################
if [[ -f ".dead_profiles.txt" ]]; then
  echo -n "Delete dead profiles? Enter y -> yes else any key -> no, 3 secounds until Timeout:"
  read -t 3 keypress
  while IFS= read -r line
  do
    if [[ $keypress == 'y' ]]; then rm -rf $line; else clear && printf '\e[3J'; fi
  done < ".dead_profiles.txt"
fi
###################################################
#created list of items in dir
ls -d */ | cut -f1 -d'/' | sort > ".gramList.txt"
###################################################
#removes items from gen list that require login
if [[ -f ".loginUsed.txt" ]];then
  grep -vf ".loginUsed.txt" ".gramList.txt" > ".temp.txt"
  cat ".temp.txt" > ".gramList.txt"
  rm ".temp.txt"
  loginflag="T"
fi
##################################################
filelist=`ls | grep -o "^glistSplit[0-9]*.txt"`
##################################################
if [[ $filelist == "" ]]; then
   $HOME/scripts/gram/b_file_list_spliter.py ".gramList.txt"
fi
###################################################
filelist=`ls | grep -o "^glistSplit[0-9]*.txt"`
for i in $filelist
do
  $HOME/scripts/gram/c_rerun-split-driver.sh "$i"&
done
###################################################
#login in and download
if [[ $loginflag == "T" ]]; then $HOME/scripts/gram/3_rerun-login.sh; fi
# #################################
#prints out start and finish time and etc
clear && printf '\e[3J'
echo ${green}"All Downloads Complete"${reset}
endTime=`date "+%I:%M %p"`; echo
echo ${orange}"startTime:$startTime"${reset}
echo ${orange}"endTime:$endTime"${Reset}
