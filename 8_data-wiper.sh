#!/usr/bin/env bash
#running bash 4
cd
cd $HOME/Pictures/0gram
##############################
for i in *
do
  if [[ -d $i ]]; then
    cd $i
    cd 0Pictures
    pwd && rm *.jpg
    cd ..
    cd 0clips
    pwd && rm *.mp4
    cd ..
    cd ..
  fi
done
