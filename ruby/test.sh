#!/usr/bin/env bash

set -e

cd "${0%/*}"
mkdir -p spec

ruby /code/texttest_fixture.rb 100 > spec/current_output.txt

if [ "$1" == "recreate" ]; then
  mv spec/current_output.txt spec/golden_master.txt
  echo "Golden master file created"
else
  if ! diff -u spec/current_output.txt spec/golden_master.txt > /tmp/diff.txt; then
    echo "Golden master testing failed"
    cat /tmp/diff.txt
  else
    echo "Golden master testing passed"
  fi
fi

cd -