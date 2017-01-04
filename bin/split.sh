#!/bin/bash


SPLIT_COUNT=7



if [ -z ${1+x} ]; then
echo "Filename not provided. Usage: '$0 filename'";
exit 1
fi

if [ ! -f $1 ]; then
echo "File not exists";
exit 2
fi

TOTAL_LINES=`cat $1 | wc -l`
echo "Tolal lines: ${TOTAL_LINES}";
LINES_PER_ITEM=$(( TOTAL_LINES / SPLIT_COUNT ))
echo "Lines per item: ${LINES_PER_ITEM}";

for (( c=1; c<=$SPLIT_COUNT; c++ ))
do
V1=$(( (c-1) * LINES_PER_ITEM ))
V2=$(( (c-1) * LINES_PER_ITEM  + LINES_PER_ITEM ))
echo "$V1 $V2"
awk 'NR > '$V1'  && NR <= '$V2' {print $0}' $1   > out_$c.txt
done

# awk 'NR > 0 && NR <= 0 + 2 { print }' in.txt

#echo $LINES_PER_ITEM
