# debug-frame-check

Check `.eh_frame` and `.debug_frame` information.

## ORC & DWARF crosscheck

Dependencies:
* GCC
* `objtool` from the Linux kernel tree
* [`dareog`](https://github.com/emersion/dareog)
* [`pyelftools`](https://github.com/eliben/pyelftools)
* [Csmith](https://embed.cs.utah.edu/csmith/) (optional)

Usage:

```shell
bin/dwarf-orc-crosscheck.sh test.c
```

(You can set `CC`, `OBJTOOL` and `DAREOG` environment variables to paths to
these tools)

Csmith example usage:

```shell
env CC=gcc CFLAGS="-I/usr/include/csmith-2.3.0/ -w" OBJTOOL=../../linux/tools/objtool/objtool DAREOG=../../dareog/build/dareog bin/dwarf-orc-csmith.sh
```

## License

MIT
