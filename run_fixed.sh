#!/bin/sh

TARGETS="segfault fixed"
COMPILERS="gcc clang"
COMPILE_OPTIONS="-g -Og -O0 -O1 -O2 -O3"

for target in $TARGETS; do
	for compiler in $COMPILERS; do
		for variant in $COMPILE_OPTIONS; do
			echo "running $target with $compiler $variant"
			$compiler -m64 $variant $target.c -o $target && ./$target
		done
	done
done
