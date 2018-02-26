#!/bin/sh

set -e -o pipefail

bin_dir=$(dirname "$0")

if [ $# -lt 1 ]; then
	echo "usage: dwarf-orc-crosscheck.sh <source-file>"
	exit 1
fi

source_file="$1"

if [ "$CC" == "" ] ; then
	CC="cc"
fi
if [ "$OBJTOOL" == "" ] ; then
	OBJTOOL="objtool"
fi
if [ "$DAREOG" == "" ] ; then
	DAREOG="dareog"
fi

# Compile the file with DWARF debugging information
dwarf_exec="$source_file-dwarf"
dwarf_obj="$dwarf_exec.o"
$CC -c "$source_file" -o "$dwarf_obj"
$CC -no-pie "$dwarf_exec.o" -o "$dwarf_exec"

# Compile the file with ORC debugging information and convert ORC to DWARF
orc_exec="$source_file-orc"
orc_obj="$orc_exec.o"
$CC -fno-asynchronous-unwind-tables -c "$source_file" -o "$orc_obj"
$OBJTOOL orc generate "$orc_obj"
$DAREOG generate-dwarf "$orc_obj"
$CC -no-pie "$orc_obj" -o "$orc_exec"

# Compare DWARF tables
$bin_dir/dwarfcmp.py "$dwarf_exec" "$orc_exec"
