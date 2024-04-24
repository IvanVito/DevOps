#!/bin/bash

if ! clang-format -Werror -n  $(pwd)/src/cat/*.c; then
  echo 'Failed in cat' && exit 1
else
  echo 'Code Style of cat passed'
fi
