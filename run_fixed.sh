#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

trap 'if [[ $? -eq 139 ]]; then echo -e "${RED}segfault!${ENDCOLOR}"; fi' CHLD

TARGETS="segfault fixed intrinsics"
COMPILERS="gcc clang"
COMPILE_OPTIONS="-g -Og -O0 -O1 -O2 -O3"

for target in $TARGETS; do
	echo -e "\n$target:"
	for compiler in $COMPILERS; do
		for variant in $COMPILE_OPTIONS; do
			compile_command="$compiler -m64 $variant $target.c"
			echo -en "\t$compile_command: "
			$compile_command
			output=$(./a.out 2>&1)
			returnval=$?
			unique_lines=$(echo "$output" | sort -u | wc -l)
			if [[ $returnval != 139 ]] && [[ $unique_lines -eq 1 ]]; then
				echo -e "${GREEN}success!${ENDCOLOR}"
			elif [ ! -z "$output" ]; then
				echo -e "${RED}different addresses:${ENDCOLOR}\n$output"
			fi
		done
	done
done

echo ""
echo "the diff between segfault.c and fixed.c is"
diff segfault.c fixed.c
echo ""

