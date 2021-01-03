#!/bin/bash

make -j8 && \
    sudo make install && \
    ./src/chocolate-doom \
    -iwad doom.wad
