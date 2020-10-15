#!/usr/bin/env bash

# Copyright IBM 2018-2020 All Rights Reserved
#
# SPDX-License-Identifier: MIT
#

declare -A dict

[[ -n ${DEBUG} ]] && set -eox

if ! [ -z $1 ]; then
    if [[ -d $1 ]]
    then
        cd $1
    fi
fi

echo "Looking for problematic words in $(pwd)"

counter=0
dict=( ["master"]="leader" ["slave"]="follower"
       ["blacklist"]="denylist" ["whitelist"]="allowlist"
       ["grandfathered"]="legacy" ["guys"]="folks")

# Loop over the dictionary
for i in "${!dict[@]}"
do
    # print key=value
    echo "$i"="${dict[$i]}"

    for j in $(ag --ignore-dir={.git} --ignore=main.sh -G ".md" -l $i .);
    do
        sed -i "s/$i/${dict[$i]}/g" $j
        counter=$((counter+1))
    done

done

if [ "$counter" -eq "0" ]; then
    echo "No problematic words were found."
else
    echo "A total of $counter problematic words were marked for replacement."
fi
