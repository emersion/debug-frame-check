#!/bin/sh

set -e -o pipefail

bin_dir=$(dirname "$0")

if [ "$CSMITH" = "" ] ; then
	CSMITH="csmith"
fi

$CSMITH $@ > csmith.c
"$bin_dir/dwarf-orc-crosscheck.sh" csmith.c
