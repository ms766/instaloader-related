#!/usr/bin/env bash
#running bash version 5.0.3

reset=$(tput sgr0); black=$(tput setaf 0);blue=$(tput setaf 33);
cyan=$(tput setaf 37);green=$(tput setaf 64);orange=$(tput setaf 166);
purple=$(tput setaf 125);red=$(tput setaf 124);violet=$(tput setaf 61);
white=$(tput setaf 15);yellow=$(tput setaf 136);
####################################
mountedVolumes=`df | grep -io '/volumes/.*\|/media.*' | grep -vi '/Volumes/Macintosh HD - Data\|.*/storage\|.*system'`
count=0
progesscount=0
declare -A drives
####################################
if [[ $mountedVolumes == '' ]]; then
    echo ${red}'No drives mounted'${reset};echo;
    exit
else
    echo
    echo ${yellow}'id: Volume Name'${reset};echo

    #IFS determines how Bash recognizes word boundaries while splitting a sequence of character strings
    IFS=$'\n'
    for i in $mountedVolumes
    do
      let count+=1
      echo ${cyan}':'$count':' $i${reset};echo;
      drives["$count"]=$i
    done

    echo -n ${reset}"Enter an drive ${yellow}id${reset} from ${cyan}above${reset} regarding ${blue}moving${reset}, ${red}files from ${blue}Drive ${reset}-> ${red}${blue}local path /~/home/Pictures/0gram/${reset}:-> "${yellow};
    read toDirectory;

    if [[ $toDirectory != '' && " ${drives[@]} " =~ " ${drives[$toDirectory]} " && -d "${drives[$toDirectory]}/0gram" ]]; then
        echo
        echo ${drives[$toDirectory]} ${red}'Selected!'${reset}
    fi

    cd && cd "$HOME/Pictures"
    if [[ -d "0gram" ]]; then
       echo ${yellow}"/home/Pictures/0gram${red} Local Ready!${reset}"
    else
        mkdir "0gram"
    fi

    cd && cd "${drives[$toDirectory]}"
    if [[ -d "0gram" ]];then
       cd "0gram"
       for i in *
       do
          if [[ -d "$HOME/Pictures/0gram/$i" ]];then
              cd $i
              echo "$HOME/Pictures/0gram/$i ${red}Present "${blue}"coping <- ${i}fileRecordSorted.txt"${reset}
              cp "${i}fileRecordSorted.txt" "$HOME/Pictures/0gram/$i"
              cd ..
          else
              mkdir $HOME/Pictures/0gram/$i
              cd $i
              echo "$HOME/Pictures/0gram/$i ${red}Present "${blue}"coping <- ${i}fileRecordSorted.txt"${reset}
              cp "${i}fileRecordSorted.txt" "$HOME/Pictures/0gram/$i"
              cd ..
          fi

       done

    else
        echo;echo ${red}"0gram Dir NOT available"${reset}
    fi

    if [[ -f ".loginUsed.txt" ]]; then cp ".loginUsed.txt" "$HOME/Pictures/0gram"; fi
    if [[ -f ".dead_profiles.txt" ]]; then cp ".dead_profiles.txt" "$HOME/Pictures/0gram"; fi
    if [[ -f ".no_access_pp.txt" ]]; then cp ".no_access_pp.txt" "$HOME/Pictures/0gram"; fi


fi
