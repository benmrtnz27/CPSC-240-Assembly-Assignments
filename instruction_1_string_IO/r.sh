#!/bin/bash

#Author: Daniel C
#Title: BASH compile for C++

rm *.o
rm *.out

echo "Compiling files..."

nasm -f elf64 -o hello_world_simple.o hello_world_simple.asm

g++ -c -m64 -std=c++17 -fno-pie -no-pie -o driver.o driver.cpp

g++ -m64 -std=c++17 -fno-pie -no-pie -o object_file_compiled.out hello_world_simple.o driver.o

echo "Running program, compilation successful."

./object_file_compiled.out