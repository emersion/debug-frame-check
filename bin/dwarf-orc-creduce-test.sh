#!/bin/sh

bin_dir=$(dirname "$0")

if [ "$CREDUCE_FILE" = "" ] ; then
	echo "Missing \$CREDUCE_FILE"
	exit 1
fi

"$bin_dir/dwarf-orc-crosscheck.sh" "$CREDUCE_FILE"
if [ "$?" = 42 ]; then
	exit 0
else
	exit 1
fi
