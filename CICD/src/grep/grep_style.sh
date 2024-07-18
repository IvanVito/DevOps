#!/bin/bash

if ! clang-format -Werror -n $(pwd)/src/grep/*.c; then
  echo 'Failed in grep' && exit 1
else
  echo 'Code Style of grep passed'
fi
