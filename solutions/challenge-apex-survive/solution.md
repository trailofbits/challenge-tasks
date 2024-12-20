# Solution Summary

## Writeups
- https://qv4.xyz/posts/htb-ca-2024-apexsurvive/
- https://blog.elmosalamy.com/posts/apexsurvive-writeup-htb-cyber-apocalypse-2024/
- and also, the [official_writeup.md](official_writeup.md) though the other two
are considerably better written

## Scope
- The email application and the bot are out of scope, therefore should not be
directly attacked. However, they can (and should) be leveraged as unwitting
allies in getting to the solution.

## Stages
1. get `isInternal` privileges
2. get `isAdmin` privileges
3. get RCE to get the flag

Each of these stages has a different solution. Each stage is built on by the
next to finally obtain the flag.

## get `isInternal` privileges

`isInternal` privileges are required to access endpoints `addProduct` and
`addContract`. We can obtain `isInternal` by exploiting a race condition in
email verification s.t. the email saved in the database is `test@email.htb` for
our user when the verification email is sent to us, but our email's domain is
`apexsurvive.htb` when the verification token that goes in the email is
generated. Then, all we need to do is use the verification token to add
`isInternal` privileges to our user.

## get `isAdmin` privileges

`isAdmin` privileges are required to access `addContract`. We can obtain
`isAdmin` through the use of the web app's item (product) addition endpoint,
which can be used to exploit the bot, which has admin privileges, by hijacking
its session.

## get RCE to get the flag

The `addContract` endpoint has an arbitrary PDF write vuln that we need to
exploit to gain RCE by overwriting the running WSGI configuration with a
malicious file. To do this, we need to craft a polyglot file that meets the
following criteria:

0. contains code that can read the flag out of the app server
1. can be validated as a PDF (this means anything that can be wrapped in a PDF
will work, like an image) so that we can pass the PDF check and overwrite
`uwsgi.ini`
2. can be validated as a WSGI config by `uwsgi` so that `uwsgi` will execute it
