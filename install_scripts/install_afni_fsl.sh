#!/bin/bash

apt-get update -qq && apt-get install -y --allow-unauthenticated afni fsl-core

if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	exit 0
fi

#check if PATH already exist in $PROFILE
if grep -xq "export PATH=$D_DIR:\$PATH" $PROFILE #return 0 if exist
then
	exit 0
else
	#create init script
	echo "" >> $PROFILE
	echo "#afni" >> $PROFILE
	echo "export PATH=/usr/lib/afni/bin:${PATH}" >> $PROFILE
fi

#test installation
source $PROFILE
