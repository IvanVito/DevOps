#!/bin/bash

ADDRESS="machine2@10.0.2.3"
DESTINATION="/usr/local/bin"

ssh "rm $DESTINATION/s21_cat $DESTINATION/s21_grep"

scp $(pwd)/src/cat/s21_cat $ADDRESS:$DESTINATION/s21_cat
scp $(pwd)/src/grep/s21_grep $ADDRESS:$DESTINATION/s21_grep

CHECK=$(ssh $ADDRESS \
  "(find $DESTINATION -name 's21_cat' -type f -print && \
  find $DESTINATION -name 's21_grep' -type f -print) | wc -l")

if [ $CHECK -eq 2 ]; then
  echo "Deploy passed"
else
  echo "Deploy failed" && exit 1
fi
