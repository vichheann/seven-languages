#!/bin/bash
if [[ $# -ne 1 ]]; then
  echo "Usage: `basename $0` {day2|day2_find|day3}"
  exit $E_BADARGS
fi
swipl -g "consult($1), load_test_files($1), run_tests, halt."
