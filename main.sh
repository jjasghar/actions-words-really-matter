#!/usr/bin/env bash

declare -A dict

while getopts "c:p:" option; do
    case $option in
        c ) config_file=$OPTARG
        ;;
        p ) pattern=$OPTARG
        ;;
    esac
done

if [ ! $pattern ]; then
    pattern="*.md"
fi

echo "pattern: $pattern"
echo "config_file: $config_file"

# Check if $config_file does not exist use this default
if [ ! -f $cconfig_file ]; then
    dict=( ["master"]="primary" ["slave"]="secondary"
           ["blacklist"]="denylist" ["whitelist"]="allowlist"
           ["grandfathered"]="legacy" ["guys"]="folks")
# If it does exist, treat that as the source of truth
else
    # Read the dictionary from file `$config_file`
    # and save the values to the `dict` variable.
    while IFS='|' read -r key value; do
        dict[$key]=$value
    done < $config_file
fi

# Test out a single instance
# echo "${dict[guys]}"

# Loop over the dictionary
for i in "${!dict[@]}"
do
    # print key=value
    echo "$i"="${dict[$i]}"

    for j in $(ag --ignore-dir={.git} --ignore=script.sh -l $i .);
    do
        #sed -i "s/$i/${dict[$i]}/g" $j
    done

done

