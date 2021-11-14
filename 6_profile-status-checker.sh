#!/usr/bin/env bash
#running bash 4
####################################
cd "$HOME/Pictures/0gram"
####################################
IFS=$'\n'
for i in *
do
    echo $i
    if [[ -d $i ]]; then
        instaloader --no-videos --no-pictures $i &> ".error.txt"
        private_profile=`cat ".error.txt" | grep -o "\-\-login=USERNAME required"`
        dead_profile=`cat ".error.txt" | grep -o "404 Not Found"`

        if [[ $private_profile != "" ]]; then echo $i >> ".loginUsed.txt"; fi
        if [[ $dead_profile != "" ]]; then echo $i >> ".dead_profiles.txt"; fi
    fi
done
####################################
sleep 10
####################################
if [[ -f ".loginUsed.txt" ]]; then
    while IFS= read -r line
    do
      instaloader "--login=fthegram4" --no-videos --no-pictures $line &> ".error.txt"
      access_to_private_profile=`cat ".error.txt" | grep -o "Private but not followed"`
      echo $access_to_private_profile $line
      if [[ $access_to_private_profile != "" ]]; then echo $line >> ".no_access_pp.txt"; fi
    done < ".loginUsed.txt"
fi
####################################
if [[ -f ".error.txt" ]]; then rm ".error.txt"; fi
####################################
cat ".loginUsed.txt" | sort -u > ".temp.txt"
cat ".temp.txt" > ".loginUsed.txt"
####################################
cat ".dead_profiles.txt" | sort -u > ".temp.txt"
cat ".temp.txt" > ".dead_profiles.txt"
####################################
cat ".no_access_pp.txt" | sort -u > ".temp.txt"
cat ".temp.txt" > ".no_access_pp.txt"
####################################
rm ".temp.txt"
