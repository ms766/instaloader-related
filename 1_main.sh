#!/usr/bin/env bash
#running bash 4
reset=$(tput sgr0); black=$(tput setaf 0);blue=$(tput setaf 33);
cyan=$(tput setaf 37);green=$(tput setaf 64);orange=$(tput setaf 166);
purple=$(tput setaf 125);red=$(tput setaf 124);violet=$(tput setaf 61);
white=$(tput setaf 15);yellow=$(tput setaf 136);
#####################################################
os_flag="";
if [[ "$OSTYPE" == "darwin"* ]]; then os_flag+="M"; fi
if [[ "$OSTYPE" == "linux"* ]]; then os_flag+="L"; fi
#####################################################
cd && cd "$HOME/scripts/gram" && source ".env"
#####################################################
#cd in pics /0gram dir
cd && cd "$HOME/Pictures/0gram"
#creates 0 size file to avoid double downloads cmlargs 1
#####################################################
if [[ -d $1 ]]; then
cd $1
    if [[ -f "${1}fileRecordSorted.txt" ]]; then
      while IFS= read -r line
      do
        touch "$line"
      done < "${1}fileRecordSorted.txt"
    fi
cd ..
fi
#creates 0 size file to avoid double downloads cmlargs 2
#####################################################
if [[ -d $2 ]]; then
cd $2
    if [[ -f "${2}fileRecordSorted.txt" ]]; then
      while IFS= read -r line
      do
        touch "$line"
      done < "${2}fileRecordSorted.txt"
    fi
cd ..
fi
#####################################################
#####################################################
#####################################################
#####################################################
#check for a cmlarg thats not a blank
if [[ $1 == '' ]]; then
    echo;echo "${orange}Error, Enter a vaild instagram profile to download";echo
else
    #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    #login in and remove duplicated from .login
    if [ $1 = 'login' ]; then
      instaloader $username --stories $2
      clear
      echo "$2" >> ".loginUsed.txt"
      cat ".loginUsed.txt" | sort -u > ".temp.txt"
      cat ".temp.txt" > ".loginUsed.txt"; rm ".temp.txt"
    else
      instaloader $1
      echo $1
    fi
    #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    #This set $2 equal to $1
    if [[ $2 != "" ]]; then set $2; fi
    #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    if [[ ! -d $1 ]]; then echo ${red}"Error no dir prez - script terminated"${reset} && exit; fi
    #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    #prints $1 and changes into it
    echo $1; cd $1
    #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    #creates pic and clips dirs if they dont exist
    if [ ! -d "0clips" -a  "0Pictures" ]; then
        mkdir "0clips"
        mkdir "0Pictures"
    fi
    #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    #if the dir is empty then it writes out the date to fileRecord as a place holder
    dirCount=`ls . | wc -l`
    if [ $dirCount -eq 0 ]; then date > ${1}fileRecord.txt; fi
    #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    #check to see
    IFS=$(echo -en "\n\b")
    for item_in_dir in *
    do
      if [[ -f $item_in_dir ]]; then echo $item_in_dir >> "${1}fileRecord.txt"; fi
    done
    #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    #sort fileRecord file and remove dups
    if [ -f "${1}fileRecord.txt" ]; then
      cat "${1}fileRecord.txt" | sort -u > "temp.txt"
      cat "temp.txt" > "${1}fileRecordSorted.txt";
      rm "${1}fileRecord.txt"; rm "temp.txt"
    fi
    #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    #move all pics and clips to resp dirs
    #check if os is mac
    if [[ $os_flag == "M" ]];then
      find . -name "*.jpg" -maxdepth 1 -exec mv -vn '{}' "./0Pictures" ";"
      echo
      find . -name "*.mp4" -maxdepth 1 -exec mv -vn '{}' "./0clips" ";"
    #check if os is linux
    elif [[ $os_flag == "L" ]]; then
      find ./ -maxdepth 1 -name "*.jpg" -exec mv -vn '{}' "./0Pictures" \;
      echo
      find ./ -maxdepth 1 -name '*.mp4' -exec mv -vn '{}' "./0clips" \;
    fi
    #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    #del all files of size 0 with 0pic and 0 clips dirs
    #check if os is mac
    if [[ $os_flag == "M" ]];then
      echo
      echo ${green}"$1 Download Complete"${reset}
      find "./0Pictures" -size 0 -print0 | xargs -0 rm
      find "./0clips" -size 0 -print0 | xargs -0 rm
    #check if os is linux
    elif [[ $os_flag == "L" ]]; then
      echo
      echo ${green}"$1 Download Complete"${reset}
      find "./0Pictures" -size  0 -print -delete
      find "./0clips" -size  0 -print -delete
    fi
    #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    #CLEAR ROOT FOLDER OF ALL JUNK !!!
    find "." -type f ! -name "${1}fileRecordSorted.txt" -maxdepth 1 -exec rm {} \;
fi
