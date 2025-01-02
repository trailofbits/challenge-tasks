#!/bin/bash

r2 -e scr.color=false -q -c 's 0x851; pd 71' ./chal/whataxor | \
sed  -n '/mov byte/s/[^,]*,//p' | \
python3 -c 'import sys; print("".join([chr(int(line.strip(), 16)^0xAA) for line in sys.stdin]));'
