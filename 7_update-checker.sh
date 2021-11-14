#!/usr/bin/env bash
#running bash 4
##############################################################
reset=$(tput sgr0); black=$(tput setaf 0);blue=$(tput setaf 33);
cyan=$(tput setaf 37);green=$(tput setaf 64);orange=$(tput setaf 166);
purple=$(tput setaf 125);red=$(tput setaf 124);violet=$(tput setaf 61);
white=$(tput setaf 15);yellow=$(tput setaf 136);
##############################################################
picflag=""
clipflag=""
clipflag_open_all=""
count=0
declare -A olist
##############################################################
os_flag="";
if [[ "$OSTYPE" == "darwin"* ]]; then os_flag+="M"; fi
if [[ "$OSTYPE" == "linux"* ]]; then os_flag+="L"; fi

if [[ $os_flag == "M" ]]; then
  alias open="open"
elif [[ $osflag == "L" ]]; then
  alias open="xdg-open"
fi
##############################################################
cd && cd $HOME/Pictures/0gram
##############################################################
for i in *
do
  if [[ -d $i ]]; then
    cd $i
            if [[ -d "0Pictures" ]]; then
                cd 0Pictures
                if [[ `ls -1 |grep ."jpg" | wc -l` -gt 0 ]]; then
                  olist["$count"]=$i
                  echo -n $white
                  echo $count${green}':'$i #':'${purple}${#olist[@]}${green}
                  picflag="T"
                else
                  picflag="F"
                fi
                cd ..
            fi

            if [[ -d "0clips" ]]; then
                cd 0clips
                if [[ `ls -1 |grep ."mp4" | wc -l` -gt 0 ]]; then
                  echo -n $cyan
                  echo $count${yellow}':'$i #':'${purple}${#olist[@]}+1${green}
                  clipflag="T"
                else
                  clipflag="F"
                fi
                cd ..
            fi
    cd ..
  fi

  if [[ $clipflag == 'T' && $picflag == 'T' ]]; then
      echo ${blue}'-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+';
  elif [[ $picflag == 'T' ]]; then
      echo ${violet}'-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+';
  fi
  let count+=1
done

echo;


input=' ';
if [[ ${#olist[@]} -eq 0 ]]; then echo '0gram Dirs empty' && exit; fi

while [[ $input != '' ]]; do
  echo ${red}'In Ops 4 open - all (timed w auto close), alld (5 dir every 70 sec), alln (all dirs), range (from start point)'${reset}
  read -p ${orange}"Enter id of DIR to open:"$reset -r input
  if [[ $input == 'all' ]]; then
    clear && printf '\e[3J'
    countx=1
    for each in "${olist[@]}"
      do
        clear && printf '\e[3J' && printf ${blue}"$countx out ${#olist[@]} done" && sleep 1
        clear && printf '\e[3J' && printf ${blue}"$each opening NOW" && sleep 1
        open "$HOME/Pictures/0gram/$each/0Pictures"
        cd "$HOME/Pictures/0gram/$each/0clips"
        if [[ `ls -1 |grep ."mp4" | wc -l` -gt 0 ]]; then
          cd .. &&   open "$HOME/Pictures/0gram/$each/0clips"
          clear && printf '\e[3J' && printf ${Reset}" Plus 3 sec" && sleep 3
          cd ..
        fi
        clear && printf '\e[3J' && printf ${red}"$each closing in 10 sec" && sleep 1
        clear && printf '\e[3J' && printf ${orange}"$each closing in 9 sec" && sleep 2
        clear && printf '\e[3J' && printf ${yellow}"$each closing in 6 sec" && sleep 3
        clear && printf '\e[3J' && printf ${green}"$each closing in 3 sec" && sleep 3
        osascript -e 'tell application "Finder" to close every window'
        let countx+=1
      done
      exit

    elif [[ $input == range ]]; then echo -n ${red}"Enter start-point:"${reset} && read y; for KEY in "${!olist[@]}"; do if [[ $KEY -ge $y ]]; then open "$HOME/Pictures/0gram/${olist[$KEY]}/0Pictures"; fi; cd "$HOME/Pictures/0gram/${olist[$KEY]}/0clips"; if [[ `ls -1 |grep ."mp4" | wc -l` -gt 0 ]]; then cd .. && open "$HOME/Pictures/0gram/${olist[$KEY]}/0clips"; cd ..; fi done && echo ${red}'opening PIC DIRS in range'${reset} && exit


    elif [[ $input == 'all d' || $input == 'all n' ]]; then
      x=0
      for each in "${olist[@]}"
        do
          let x+=1
          if [[ x -eq 5 ]]; then sleep 70 && x=0; fi
          if [[ $input == 'all n' ]]; then x=0; fi


          open "$HOME/Pictures/0gram/$each/0Pictures"
          cd "$HOME/Pictures/0gram/$each/0clips"
          if [[ `ls -1 |grep ."mp4" | wc -l` -gt 0 ]]; then
            cd .. &&   open "$HOME/Pictures/0gram/$each/0clips"
          else
            cd ..
          fi
        done
        exit
  fi



  [[ $input != '' && -n ${olist[$input]} ]] && open "$HOME/Pictures/0gram/${olist[$input]}" || printf '\n'${red}"bad id error - Try again or hit enter to exit"${reset}'\n\n'



done
