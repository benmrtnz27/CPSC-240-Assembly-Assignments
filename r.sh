#!/bin/bash

#Author: Ben M
#Title: Assignment 1 Triangles

rm *.o
rm *.out

echo "Compiling files..."

nasm -f elf64 -o triangles.o triangles.asm

g++ -c -m64 -std=c++17 -fno-pie -no-pie -o driver.o driver.cpp

g++ -m64 -std=c++17 -fno-pie -no-pie -o object_file_compiled.out triangles.o driver.o

echo "Running program, compilation successful!"

./object_file_compiled.out
