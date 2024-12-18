# Solution
Decompile the file. Read through the decompilation and observe that it uses the
documented [flecs](https://github.com/SanderMertens/flecs) gaming Entity
Component System (ECS).

The main, system\_builder, and query functions in particular create and run a
flecs-based virtual world. The binary overall does the following:

- Creates twenty 'explorers' in random people (without attaching CanMove to
    them)
- Creates a number of 'flag parts' and scatters them around the world
- For each tick of the ECS, randomly moves people around the world (only if
they have CanMove attached)
- If they are overlapping with a flag part, we 'discover' it and add it to
our flag array

One potential solution involves patching the binary so that the explorers are
able to move. Another is to locate the creation of the FlagPart components and
extract the indexes and values.

We will navigate to 0x48b6, where we create a single-byte variable on the stack
with a value of 0. This value is then loaded and checked before branching.

```assembly
mov     byte [rbp-0xd29 {var_d31_1}], 0x0
movzx   eax, byte [rbp-0xd29 {var_d31}]  {0x0}
test    al, al
jne     0x4b78  {0x0}
```

We can (using our decompiler of choice) patch the 0x0 of the mov to 0x1. Saving
the patched version to a new file and running it, we will begin seeing
explorers discover flag parts. If we wait a short time, the whole flag will be
printed.
