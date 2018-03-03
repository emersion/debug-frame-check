#!/bin/sh

set -e -o pipefail

bin_dir=$(dirname "$0")

if [ -z "$CREDUCE" ] ; then
	CREDUCE="creduce"
fi

if [ -n "$CC" ] ; then
	export CC=$(which "$CC")
fi
if [ -n "$OBJTOOL" ] ; then
	export OBJTOOL=$(which "$OBJTOOL")
fi
if [ -n "$DAREOG" ] ; then
	export DAREOG=$(which "$DAREOG")
fi

if [ $# -lt 1 ]; then
	echo "usage: dwarf-orc-creduce.sh <source-file>"
	exit 1
fi

source_file="$1"
basename=$(basename "$source_file" ".c")

export CREDUCE_FILE="$basename-creduce.c"
cp "$source_file" "$CREDUCE_FILE"

"$bin_dir/dwarf-orc-creduce-test.sh"
$CREDUCE "$bin_dir/dwarf-orc-creduce-test.sh" "$CREDUCE_FILE"
"$bin_dir/dwarf-orc-creduce-test.sh"
