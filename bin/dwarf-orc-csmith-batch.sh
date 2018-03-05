#!/bin/sh

bin_dir=$(dirname "$0")

optimization_flags="-O0 -O1 -O2 -O3"
frame_pointer_flags="-fomit-frame-pointer -fno-omit-frame-pointer"

i=0
while true; do
	optimization_flag=$(shuf -e -n1 -- $optimization_flags)
	frame_pointer_flag=$(shuf -e -n1 -- $frame_pointer_flags)
	cflags="$optimization_flag $frame_pointer_flag"

	objtoolflags=""
	if [ "$frame_pointer_flag" = "-fomit-frame-pointer" ] ; then
		objtoolflags="--no-fp"
	fi

	export CFLAGS="$CFLAGS $cflags"
	export OBJTOOLFLAGS="$OBJTOOLFLAGS $objtoolflags"

	# TODO: pass random options to csmith
	"$bin_dir/dwarf-orc-csmith.sh"
	if [ "$?" -ne 0 ]; then
		source_file="csmith-$i.c"
		env_file="csmith-$i.env"

		cp "csmith.c" "$source_file"

		>"$env_file"
		echo "CFLAGS=$cflags" >> "$env_file"
		echo "OBJTOOLFLAGS=$objtoolflags" >> "$env_file"

		((i++))
	fi
done
