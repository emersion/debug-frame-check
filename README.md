# debug-frame-check

Check `.eh_frame` and `.debug_frame` information.

## ORC & DWARF crosscheck

Dependencies:
* GCC
* `objtool` from the Linux kernel tree
* [`dareog`](https://github.com/emersion/dareog)
* [`pyelftools`](https://github.com/eliben/pyelftools)

Usage:

```shell
bin/dwarf-orc-crosscheck.sh test.c
```

(You can set `CC`, `OBJTOOL` and `DAREOG` environment variables to paths to
these tools)

## License

MIT
