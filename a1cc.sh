#!/bin/bash
test $# -ne 2 && {
  echo "[Usage]   $0 hamlog_data.csv a1c_member_list"
  exit 1
}
TEMP=$(mktemp)
awk -F ',' '{print $1}' $1 | sed 's%/.*%%g' | sort | uniq >$TEMP
M=$(comm -12 $TEMP <(awk '{print $1}' $2 | sort) | wc -l)
echo "members: $M"
A=$(wc -l <$TEMP)
echo "all: $A"
rm -rf $TEMP

if test $A -le $((M * 5)); then
  echo OK
else
  echo NG
fi
