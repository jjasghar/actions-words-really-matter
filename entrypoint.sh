#!/bin/sh

cd /mnt

# -i for case insensitive search
# --ignore-file for the script
# --ignore-dir for .git
# ag uses files in .gitignore by default









#for i in $(ag --ignore-dir={.git} --ignore=script.sh -l Master .);
#do
#	sed -i s/Master/Leader/g $i
#done
