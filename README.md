# debug-frame-check

Check `.eh_frame` and `.debug_frame` information.

## ORC & DWARF crosscheck

Dependencies:
* `objtool` from the Linux kernel tree
* [`dareog`](https://github.com/emersion/dareog)
* [`pyelftools`](https://github.com/eliben/pyelftools)

Manual usage:

```shell
# Compile the file with DWARF debugging information
gcc -c test.c -o test-dwarf.o
gcc -no-pie test-dwarf.o -o test-dwarf

# Compile the file with ORC debugging information and convert ORC to DWARF
gcc -fno-asynchronous-unwind-tables -c test.c -o test-orc.o
objtool orc generate test-orc.o
dareog generate-dwarf test-orc.o
gcc -no-pie test-orc.o -o test-orc

# Compare DWARF tables
bin/dwarfcmp.py test-dwarf test-orc
```

## License

MIT
