#!/bin/bash

make -j8 && \
    sudo make install && \
    # gdb --args ./src/chocolate-doom \
    ./src/chocolate-doom \
    -iwad doom.wad \
    -window
