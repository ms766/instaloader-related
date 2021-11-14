#!/usr/bin/env bash
#running bash 4
reset=$(tput sgr0); black=$(tput setaf 0);blue=$(tput setaf 33);
cyan=$(tput setaf 37);green=$(tput setaf 64);orange=$(tput setaf 166);
purple=$(tput setaf 125);red=$(tput setaf 124);violet=$(tput setaf 61);
white=$(tput setaf 15);yellow=$(tput setaf 136);
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#
chmod -R 777 ./
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#
if [[ "$OSTYPE" == "darwin"* ]]; then
   sed -i 's/\\//' $HOME/scripts/gram/0_setup.sh
fi
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#
instaloadercheck_installed=`pip3 freeze | grep "instaloader"`
instaloadercheck_updateRequired=`pip3 list --outdated | grep "instaloader"`
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#
if [[ "$instaloadercheck_installed" == "" ]]; then
    pip3 install instaloader
elif [[ $instaloadercheck_updateRequired != "" ]];then
    pip3 install --upgrade instaloader
else
    echo "instaloader installed already"
fi
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#
#jump to root dir
cwd=`pwd`
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#
#check for scripts directory
function scriptscheck(){
while true;
do
cd
if [ -d "scripts" ]; then
    cd "scripts"
    if [ -d "gram" ]; then
       echo ${yellow}"All relevant script present & ready for use"${reset}
       return 0
    else
       echo ${yellow}"All relevant script loaded & ready for use"${reset}
       cp -r "$cwd" "."
       return 0
    fi
else
    mkdir "scripts"
fi
done
}
scriptscheck
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#
cd
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#
#check for pics dir
if [ -d 'Pictures' ]; then
  cd "Pictures"
  #check if 0gram dir exist
  if [ -d '0gram' ]; then
     echo ${green}"All relevant directories present"${reset}
   else
     echo ${green}"All relevant directories loaded – base setup complete!"${reset}
     mkdir "0gram"
  fi
else
  mkdir "Pictures"
  cd "Pictures"
  mkdir "0gram"
  echo ${green}"All relevant directories present – base setup complete!"${reset}
fi
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#
cd
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#
if [[ ! -f ".bash_profile" ]]; then
  echo "source .bashrc" > $HOME/.bash_profile
fi
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#
if [[ -f ".bashrc" ]]; then
bashrc_check=`cat ".bashrc" | grep "instgramDL()"`
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#

if [[ $bashrc_check == "" ]]; then
cat >> .bashrc << END
function instgramDL(){
	if [[ "\$1" == '-r' ]]; then
		cd && cd scripts/gram && ./2_rerun.sh && cd $HOME/Desktop
	elif [[ "\$1" == '-clear' ]]; then
		cd && cd scripts/gram && ./8_data-wiper.sh && cd $HOME/Desktop
  elif [[ "\$1" == '-rr' ]]; then
    cd && cd scripts/gram && ./a_rerun-split-helper.sh && cd $HOME/Desktop
	elif [[ "\$1" == '-check' ]]; then
		cd && cd scripts/gram && ./7_update-checker.sh && cd $HOME/Desktop
	elif [[ "\$1" == '-move' ]]; then
		cd && cd scripts/gram && ./4_move-in-out.sh && cd $HOME/Desktop
  elif [[ "\$1" == '-rmove' ]]; then
        cd /Users/ms/scripts/gram && ./5_rmove-out-in.sh $1 && cd $HOME/Desktop
  elif [[ "\$1" == '-reset' ]]; then
    cd Pictures/0gram && rm ".current_state.txt" ".done_state.txt" ".gramList.txt" ".login_current_state.txt" ".temp_login_state.txt" ".login_done_state.txt" >/dev/null 2>&1
  elif [[ "\$1" == '-help' ]]; then
    echo 'Enter: -clear -> clears all dirs'
    echo 'Enter: -check -> checks each dir download state'
    echo 'Enter: -move -> copies all files > 0 to chosen dir'
    echo 'Enter: -reset -> deletes all states in terms of downloads'
    echo 'Enter: -trash -> deletes a given dir and all related files'
	elif [[ ! "\$1" =~ ^"-" ]];then
	  cd $HOME/scripts/gram && ./1_main.sh \$@ && cd $HOME/Desktop
	fi
}

alias gram="instgramDL"
END
fi
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#
fi
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#
echo -n "Enter 'y' to del the setup files 'any other key2' to exit :"
read res
if [[ $res == "y" ]]; then
  cd
  rm -rf $cwd
else
  exit
fi
#--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--#
