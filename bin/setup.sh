#!/bin/sh

set -e

vendor_dir="$(pwd)/vendor"
env_file="$vendor_dir/env"

mkdir -p "$vendor_dir"
>"$env_file"

if ! [ -x "$(command -v objtool)" ]; then
	cd "$vendor_dir"
	if ! [ -d linux ] ; then
		git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git --depth 1
	fi
	cd linux/tools/objtool
	make
	echo OBJTOOL="$vendor_dir/linux/tools/objtool/objtool" >> "$env_file"
fi

cd "$vendor_dir"
if ! [ -d pyelftools ] ; then
	git clone https://github.com/eliben/pyelftools.git
fi
echo PYTHONPATH="$vendor_dir/pyelftools" >> "$env_file"

if ! [ -x "$(command -v dareog)" ]; then
	cd "$vendor_dir"
	if ! [ -d dareog ] ; then
		git clone https://github.com/emersion/dareog.git
	fi
	cd dareog
	git submodule init
	git submodule update
	if ! [ -d build ] ; then
		meson build
	fi
	ninja -C build
	echo DAREOG="$vendor_dir/dareog/build/dareog" >> "$env_file"
fi

if [ -x "$(command -v csmith)" ]; then
	cd "$vendor_dir"
	if ! [ -d csmith ] ; then
		git clone https://github.com/csmith-project/csmith.git
	fi
	cd csmith
	cmake .
	make
	echo CSMITH="$vendor_dir/csmith/csmith" >> "$env_file"
fi

if [ -x "$(command -v csmith)" ]; then
	cd "$vendor_dir"
	if ! [ -d creduce ] ; then
		git clone https://github.com/csmith-project/creduce.git
	fi
	cd creduce
	./configure
	make
	echo CREDUCE="$vendor_dir/creduce/creduce" >> "$env_file"
fi

echo "Setup complete!"
echo "To use the tools for this session, run:"
echo '  export $(cat vendor/env)'
