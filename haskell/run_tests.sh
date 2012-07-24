#!/bin/bash
if [[ $# -ne 1 ]]; then
  echo "Usage: `basename $0` {day1|day2|day2_bonus|day3}"
  exit $E_BADARGS
fi
ghc -e main "$1"_test.hs
