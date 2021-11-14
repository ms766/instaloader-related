#!/bin/bash

# The IFS variable is used in shells (Bourne, POSIX, ksh, bash) as the input field separator (or internal field separator).
#Essentially, it is a string of special characters which are to be treated as delimiters between words/fields when splitting a line of input.
#The default value of IFS is space, tab, newline.

reset=$(tput sgr0); black=$(tput setaf 0);blue=$(tput setaf 33);
cyan=$(tput setaf 37);green=$(tput setaf 64);orange=$(tput setaf 166);
purple=$(tput setaf 125);red=$(tput setaf 124);violet=$(tput setaf 61);
white=$(tput setaf 15);yellow=$(tput setaf 136);



countdown()
(
  IFS=:
  set -- $*
  secs=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))
  while [ $secs -gt -1 ]
  do
    if [ $secs -gt 3600 ]
      then
        sleep 1 &
        printf ${green}"\r%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
        secs=$(( $secs - 1 ))
        wait
      elif [ $secs -lt 3600 ] && [ $secs -gt 60 ]
      then
        sleep 1 &
        printf ${yellow}"\r%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
        secs=$(( $secs - 1 ))
        wait
      else
          sleep 1 &
          printf ${red}"\r%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
          secs=$(( $secs - 1 ))
          wait
        fi
  done
)

if [ $# -eq 0 ]
  then
    echo ${yellow}"No arguments supplied"
    echo "Default time of 5 mins set"${reset};echo
    countdown "00:05:00";echo -n
  else
    echo
    if [ $# -eq 1 ]
      then
        countdown "00:$1:00"
    elif [ $# -eq 2 ]
      then
        countdown "$1:$2:00"
    elif [ $# -eq 3 ]
      then
        countdown "$1:$2:$3"
  fi
fi

#clear && printf '\e[3J'
