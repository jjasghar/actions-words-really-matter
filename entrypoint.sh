#!/bin/sh

cd /mnt

for i in $(ag --ignore-dir={.git} --ignore=script.sh -l master .);
do
	sed -i s/master/leader/g $i
done
for i in $(ag --ignore-dir={.git} --ignore=script.sh -l Master .);
do
	sed -i s/Master/Leader/g $i
done
for i in $(ag --ignore-dir={.git} --ignore=script.sh -l MASTER .);
do
	sed -i s/MASTER/LEADER/g $i
done
for i in $(ag --ignore-dir={.git} --ignore=script.sh -l slave .);
do
	sed -i s/slave/follower/g $i
done
for i in $(ag --ignore-dir={.git} --ignore=script.sh -l Slave .);
do
	sed -i s/Slave/Follower/g $i
done
for i in $(ag --ignore-dir={.git} --ignore=script.sh -l SLAVE .);
do
	sed -i s/SLAVE/FOLLOWER/g $i
done
