#!/bin/bash

#
# Mock uname: emulate uname output of Ubuntu 14.04.
#

opt_s='Linux'
opt_n=$(hostname)
opt_r='4.2.0-19-generic'
opt_v='#23-Ubuntu SMP Wed Nov 11 11:39:30 UTC 2015'
opt_m='x86_64'
opt_p='x86_64'
opt_i='x86_64'
opt_o='GNU/Linux'
opt_a="${opt_s} ${opt_n} ${opt_r} ${opt_v} ${opt_m} ${opt_p} ${opt_i} ${opt_o}"

case "$1" in
  -s) echo "$opt_s" ;;
  -n) echo "$opt_n" ;;
  -r) echo "$opt_r" ;;
  -v) echo "$opt_v" ;;
  -m) echo "$opt_m" ;;
  -p) echo "$opt_p" ;;
  -i) echo "$opt_i" ;;
  -o) echo "$opt_o" ;;
  -a) echo "$opt_a" ;;
  '') echo "$opt_s" ;;
   *) exit 1 ;;
esac

exit 0
