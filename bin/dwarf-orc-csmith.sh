#!/bin/sh

set -e -o pipefail

bin_dir=$(dirname "$0")

csmith $@ > csmith.c
"$bin_dir/dwarf-orc-crosscheck.sh" csmith.c
