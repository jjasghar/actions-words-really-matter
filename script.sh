#!/bin/bash

SED=$(gsed)

for i in $(ag --ignore-dir={.git,.hg} -f master .);
do
	${SED} -i s/master/leader/g $i
done
